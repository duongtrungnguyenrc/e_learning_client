class ResetPasswordState {
  bool loading;
  String? errorMessage;
  String? message;

  ResetPasswordState({
    this.loading = false,
    this.errorMessage,
    this.message,
  });

  ResetPasswordState clear() {
    return ResetPasswordState();
  }

  ResetPasswordState copyWith({
    bool? loading,
    String? errorMessage,
    String? message,
  }) {
    return ResetPasswordState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      message: message ?? this.message,
    );
  }
}
