import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/domain/business/events/update_profile_bloc.event.dart';
import 'package:lexa/domain/business/states/update_profile_bloc.state.dart';
import 'package:lexa/domain/repositories/user.repository.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileState()) {
    on<UpdateProfile>((event, emit) async {
      emit(state.copyWith(loading: true));

      await UserRepository.updateProfile(event.payload).then((response) {
        print(response);
        emit(state.copyWith(
          newProfile: response.data,
          loading: false,
        ));
      }).onError((DioException exception, stackTrace) {
        print(exception);
        emit(
          state.copyWith(
            errorMessage: exception.response?.data['message'] ?? "Unknow error",
          ),
        );
      }).whenComplete(() {
        emit(state.clear());
      });
    });
  }
}
