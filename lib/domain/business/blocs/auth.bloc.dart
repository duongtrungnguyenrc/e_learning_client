// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lexa/data/dtos/base_response.dto.dart';
import 'package:lexa/domain/business/events/login_bloc.event.dart';
import 'package:lexa/domain/business/states/login_bloc.state.dart';
import 'package:lexa/domain/repositories/auth.repository.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lexa/data/dtos/sign_in_response.dto.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<DefaultAuth>(
      (event, emit) async {
        emit(AuthLoading());

        try {
          final res = await AuthRepository.auth(event.email, event.password);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("access_token", res.data.accessToken);
          prefs.setString("refresh_token", res.data.refreshToken);

          emit(AuthSuccess(res.data));
        } on DioException catch (e) {
          emit(AuthFail(message: e.message ?? "Undefine error"));
        } catch (e) {
          emit(AuthFail(message: "Unknow error"));
        }
      },
    );

    on<TokenAuth>(
      (event, emit) async {
        emit(AuthLoading());

        try {
          final res = await AuthRepository.tokenAuth();
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("access_token", res.data.accessToken);
          prefs.setString("user_profile", res.data.user.toJson());

          emit(AuthSuccess(res.data));
        } on NetworkException catch (e) {
          emit(AuthFail(message: e.message ?? "Undefine error"));
        } catch (e) {
          emit(AuthFail(message: "Undefine error"));
        }
      },
    );

    on<GoogleAuth>(
      (event, emit) async {
        emit(AuthLoading());
        final loginUrl = await AuthRepository.getGoogleSignInUrl();
        emit(GoogleAuthUrl(url: loginUrl));
      },
    );

    on<GoogleAuthResponse>(
      (event, emit) async {
        final loginResponse = BaseResponse.fromMap(
            json.decode(event.uri.queryParameters['payload'] ?? "")
                as Map<String, dynamic>,
            SignInResponseDto.fromMap);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("access_token", loginResponse.data.accessToken);
        prefs.setString("user_profile", loginResponse.data.user.toJson());

        emit(AuthSuccess(loginResponse.data));
      },
    );
  }
}
