import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/domain/business/events/home_bloc.event.dart';
import 'package:lexa/domain/business/states/home_bloc.state.dart';
import 'package:lexa/domain/repositories/topic.repository.dart';
import 'package:lexa/domain/repositories/user.repository.dart';

class Homebloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  Homebloc() : super(HomeBlocState()) {
    on<LoadRecommendTopics>((event, emit) async {
      try {
        final res = await TopicRepository.loadRecommendTopics();
        emit(state.copyWith(recommendTopics: res.data));
      } catch (e) {
        print(e);
      }
    });

     on<LoadTopAuthor>((event, emit) async {
      try {
        final res = await UserRepository.loadTopAuthors();
        emit(state.copyWith(topAuthors: res.data));
      } catch (e) {
        print(e);
      }
    });
  }
}
