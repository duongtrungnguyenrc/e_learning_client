import 'package:lexa/data/models/user.model.dart';

class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String? id;

  LoadProfile({this.id});
}

class ClearProfile extends ProfileEvent {}

class LoadProfileTopics extends ProfileEvent {}

class UpdateSystemProfile extends ProfileEvent {
  final User newProfile;

  UpdateSystemProfile(this.newProfile);
}
