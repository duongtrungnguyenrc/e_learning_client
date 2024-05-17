// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lexa/data/dtos/destroy_forgot_password.dto.dart';

class ForgotPasswordEvent {}

class CreateForgotPasswordTransaction extends ForgotPasswordEvent {
  String userId;

  CreateForgotPasswordTransaction({
    required this.userId,
  });
}

class DestroyForgotPasswordTransaction extends ForgotPasswordEvent {
  final DestroyForgotPasswordTransactionDto payload;

  DestroyForgotPasswordTransaction({required this.payload});
}

class ClearForgotPasswordTransaction extends ForgotPasswordEvent {}
