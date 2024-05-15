class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String? id;

  LoadProfile({this.id});
}

class ClearProfile extends ProfileEvent {}

class LoadProfileTopics extends ProfileEvent {}
