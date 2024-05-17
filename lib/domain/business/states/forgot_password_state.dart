class ForgotPasswordState {
  final bool? loading;
  final Exception? exception;
  final String? transaction;

  ForgotPasswordState({
    this.loading,
    this.exception,
    this.transaction,
  });

  ForgotPasswordState clear() {
    return ForgotPasswordState();
  }

  ForgotPasswordState copyWith({
    bool? loading,
    Exception? exception,
    String? transaction,
  }) {
    return ForgotPasswordState(
      loading: loading,
      exception: exception,
      transaction: transaction ?? this.transaction,
    );
  }
}

class TransactionState extends ForgotPasswordState {
  TransactionState({
    super.loading,
    super.exception,
    super.transaction,
  });
}
