import 'package:lexa/data/dtos/sign_in_response.dto.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final SignInResponseDto response;

  AuthSuccess(this.response);
}

class AuthFail extends AuthState {
  final String message;

  AuthFail({
    required this.message,
  });
}

class GoogleAuthUrl extends AuthState {
  final String url;

  GoogleAuthUrl({
    required this.url,
  });
}
