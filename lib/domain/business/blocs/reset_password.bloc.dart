import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/dtos/reset_passord.dto.dart';
import 'package:lexa/domain/business/events/reset_password_bloc.event.dart';
import 'package:lexa/domain/business/states/reset_password_bloc.state.dart';
import 'package:lexa/domain/repositories/user.repository.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState()) {
    on<ResetPassword>((event, emit) async {
      await UserRepository.resetPassword(ResetPasswordDto(
        event.transactionId,
        event.otp,
        event.password,
      )).then((response) {
        emit(state.copyWith(message: response.message));
      }).onError((DioException e, StackTrace stackTrace) {
        emit(state.copyWith(errorMessage: e.response?.data['message'].toString()));
      }).whenComplete(() {
        emit(state.clear());
      });
    });
  }
}
