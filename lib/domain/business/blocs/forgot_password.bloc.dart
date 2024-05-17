import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/domain/business/events/forgot_password_bloc.event.dart';
import 'package:lexa/domain/business/states/forgot_password_state.dart';
import 'package:lexa/domain/repositories/user.repository.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<CreateForgotPasswordTransaction>((event, emit) async {
      emit(state.copyWith(
        loading: true,
      ));

      await UserRepository.createForgotPasswordTransaction(event.userId).then((response) {
        emit(TransactionState(transaction: response.data.transactionId));
      }).onError((DioException e, StackTrace stackTrace) {
        emit(state.copyWith(exception: e));
      }).whenComplete(() {
        emit(state.copyWith(
          exception: null,
          loading: null,
        ));
      });
    });

    on<ClearForgotPasswordTransaction>((event, emit) {
      emit(state.clear());
    });

    on<DestroyForgotPasswordTransaction>((event, emit) async {
      await UserRepository.destroyForgotPasswordTransaction(event.payload);
    });
  }
}
