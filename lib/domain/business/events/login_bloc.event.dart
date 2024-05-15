abstract class AuthEvent {}

class GoogleAuth extends AuthEvent {}

class GoogleAuthResponse extends AuthEvent {
  final Uri uri;

  GoogleAuthResponse({required this.uri});
}

class DefaultAuth extends AuthEvent {
  final String email;
  final String password;

  DefaultAuth({
    required this.email,
    required this.password,
  });
}

class TokenAuth extends AuthEvent {}
