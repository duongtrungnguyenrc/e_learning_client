class FindAccountEvent {}

class FindAccount extends FindAccountEvent {
  String key;
  FindAccount({
    required this.key,
  });
}

class ClearFoundAccounts extends FindAccountEvent {}
