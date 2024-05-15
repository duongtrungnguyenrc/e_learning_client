// ignore_for_file: public_member_api_docs, sort_constructors_first
class ValidationResult {
  bool isTrue;
  String message;

  ValidationResult({
    required this.isTrue,
    required this.message,
  });
}

abstract class Validator {
  ValidationResult? validate();
}
