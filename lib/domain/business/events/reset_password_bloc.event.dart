class ResetPasswordEvent {}


class ResetPassword extends ResetPasswordEvent {
  final String transactionId;
  final String otp;
  final String password;

  ResetPassword(this.transactionId, this.otp, this.password);
}
