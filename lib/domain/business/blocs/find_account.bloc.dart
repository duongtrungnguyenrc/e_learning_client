import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/domain/business/events/find_account_bloc.event.dart';
import 'package:lexa/domain/business/states/find_account_bloc.state.dart';
import 'package:lexa/domain/repositories/user.repository.dart';

class FindAccountBloc extends Bloc<FindAccountEvent, FindAccountState> {
  FindAccountBloc() : super(FindAccountState()) {
    on<FindAccount>((event, emit) async {
      emit(state.copyWith(
        loading: true,
      ));

      await UserRepository.findAccounts(event.key).then((response) {
        emit(state.addAll(response.data));
      }).onError((DioException e, StackTrace stackTrace) {
        emit(state.copyWith(exception: e));
      }).whenComplete(() {
        emit(state.copyWith(
          exception: null,
          loading: false,
        ));
      });
    });

    on<ClearFoundAccounts>((event, emit) {
      emit(state.clear());
    });
  }
}
