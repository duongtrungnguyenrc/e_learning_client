import 'package:lexa/data/models/user.model.dart';

class UpdateProfileState {
  final bool loading;
  final String? errorMessage;
  final User? newProfile;

  UpdateProfileState({
    this.loading = false,
    this.errorMessage,
    this.newProfile,
  });

  UpdateProfileState copyWith({
    bool? loading,
    String? errorMessage,
    User? newProfile,
  }) {
    return UpdateProfileState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      newProfile: newProfile ?? this.newProfile,
    );
  }

  UpdateProfileState clear() => UpdateProfileState();
}
