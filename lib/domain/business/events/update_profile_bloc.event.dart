import 'package:lexa/data/dtos/update_profile.dto.dart';

class UpdateProfileEvent {}

class UpdateProfile extends UpdateProfileEvent {
  UpdateProfileDto payload;

  UpdateProfile(this.payload);
}
