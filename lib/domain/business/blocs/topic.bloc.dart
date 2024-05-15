import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/domain/business/events/topic_bloc.event.dart';
import 'package:lexa/domain/business/states/topic.state.dart';
import 'package:lexa/domain/repositories/topic.repository.dart';

import 'offline_data.bloc.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final OfflineDataBloc _offlineDataBloc;

  TopicBloc(this._offlineDataBloc) : super(TopicState()) {
    on<Loadtopic>((event, emit) async {
      try {
        final res = await TopicRepository.loadTopic(event.id);
        final Topic topic = res.data;

        if (_offlineDataBloc.state.getNode(topic.id) == null) {
          topic.isDownloaded = true;
        }

        emit(state.addNode(topic));
      } catch (e) {
        print(e);
      }
    });
  }
}
