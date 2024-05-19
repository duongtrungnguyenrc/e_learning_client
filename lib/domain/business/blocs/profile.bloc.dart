import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/domain/business/events/profile_bloc.event.dart';
import 'package:lexa/domain/business/states/profile_bloc.state.dart';
import 'package:lexa/domain/repositories/user.repository.dart';
import 'package:lexa/core/exceptions/network.exception.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<LoadProfile>((event, emit) async {
      try {
        final res = await UserRepository.loadProfile(event.id);
        emit(
          state.addNode(res.data).copyWith(
                currentNode: res.data.id,
              ),
        );
      } catch (e) {
        print(e);
      }
    });

    on<ClearProfile>((event, emit) {
      emit(state.copyWith(currentNode: null));
    });

    on<LoadProfileTopics>((event, emit) async {
      try {
        final res = await UserRepository.loadAuthenticatedProfileTopics();
        final existingNode =
            state.getAuthenticatedNode()?.copyWith(topics: res.data);

        emit(state.addNode(existingNode));
      } on NetworkException catch (e) {
        print(e);
      }
    });

    on<UpdateSystemProfile>(
      (event, emit) {
        final Profile newProfile = Profile(
          id: event.newProfile.id,
          avatar: event.newProfile.avatar,
          name: event.newProfile.name,
          email: event.newProfile.email,
          phone: event.newProfile.phone,
        );
        emit(
          state.addNode(
            newProfile,
          ),
        );
      },
    );
  }
}
