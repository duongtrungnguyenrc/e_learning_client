import 'package:lexa/data/models/user.model.dart';

class FindAccountState {
  final bool loading;
  final Exception? exception;
  final List<User>? users;

  FindAccountState({
    this.loading = false,
    this.exception,
    this.users,
  });

  FindAccountState addAll(List<User> users) {
    return copyWith(users: [...this.users ?? [], ...users]);
  }

  FindAccountState clear() {
    return FindAccountState();
  }

  FindAccountState clearTransaction() {
    return FindAccountState(
      users: users,
      loading: loading,
      exception: exception,
    );
  }

  FindAccountState copyWith({
    List<User>? users,
    bool? loading,
    Exception? exception,
  }) {
    return FindAccountState(
      users: users ?? this.users,
      loading: loading ?? this.loading,
      exception: exception,
    );
  }
}
