import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/models/multiple_choice_answer.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/data/models/vocabulary.model.dart';
import 'package:lexa/domain/business/events/offline_data_bloc.event.dart';
import 'package:lexa/domain/business/states/offline_data_bloc.state.dart';
import 'package:lexa/domain/utils/local_database_helper.utils.dart';

class OfflineDataBloc extends Bloc<OfflineDataEvent, OfflineDataState> {
  final _localDbHelper = LocalDatabaseHelper();

  OfflineDataBloc() : super(OfflineDataState()) {
    _loadSavedTopics();

    on<SaveTopic>((event, emit) async {
      emit(state.copyWith(loading: true));

      final authorId = await _localDbHelper.insert("user", event.topic.author.toMap());
      final folderId =
          event.topic.folder != null ? await _localDbHelper.insert("folder", event.topic.folder!.toMap()) : null;

      final topicId = await _localDbHelper.insert('topic', {
        'id': event.topic.id,
        'name': event.topic.name,
        'description': event.topic.description,
        'visibility': event.topic.visibility ? 1 : 0,
        'thumbnail': event.topic.thumbnail,
        'createdTime': event.topic.createdTime,
        'authorId': authorId,
        'folderId': folderId,
      });

      for (Vocabulary vocabulary in event.topic.vocabularies) {
        await _localDbHelper.insert('vocabulary', {
          'id': vocabulary.id,
          'word': vocabulary.word,
          'meaning': vocabulary.meaning,
          'description': vocabulary.description,
          'imgDescription': vocabulary.imgDescription,
          'createdTime': vocabulary.createdTime,
          'topicId': topicId,
        });
      }

      for (Vocabulary vocabulary in event.topic.vocabularies) {
        for (MultipleChoiceAnswer answer in vocabulary.multipleChoiceAnswers) {
          await _localDbHelper.insert('multiple_choice_answer', {
            'id': answer.id,
            'content': answer.content,
            'isTrue': answer.isTrue ? 1 : 0,
            'vocabularyId': vocabulary.id,
          });
        }
      }

      emit(state.addNode(event.topic));

      state.printGraph();
    });
  }

  void _loadSavedTopics() async {
    final topicsData = await _localDbHelper.query("topic").select([]).execute();

    final topics = await Future.wait(topicsData.map<Future<Topic>>((topic) async {
      final visibility = int.parse(topic['visibility'].toString()) == 0 ? false : true;
      final author = await _localDbHelper.query("user").select([]).where({'id': topic['authorId']}).execute();
      final vocabularies =
          await _localDbHelper.query("vocabulary").select([]).where({'topicId': topic['id']}).execute();

      return Topic.fromMap({
        ...topic,
        '_id': topic['id'],
        'visibility': visibility,
        'author': author.isNotEmpty ? author[0] : null,
        'vocabularies': await Future.wait(vocabularies.map<Future<Map<String, dynamic>>>((vocabulary) async {
          final answers = (await _localDbHelper
                .query("multiple_choice_answer")
                .select([]).where({'vocabularyId': vocabulary['id']})
                .execute())
              .map((answer) {
            return {
              ...answer,
              'isTrue': int.parse(answer['isTrue'].toString()) == 0 ? false : true,
            };
          });

          return {
            ...vocabulary,
            'multipleChoiceAnswers': answers,
          };
        })),
      });
    }));

    Map<String, Topic> newGraph = {};

    for (var topic in topics) {
      newGraph[topic.id] = topic;
    }

    emit(state.copyWith(savedTopics: newGraph));
  }
}
