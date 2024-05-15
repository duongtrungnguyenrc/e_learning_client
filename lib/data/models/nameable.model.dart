import 'package:lexa/data/models/base.model.dart';

class Nameable extends BaseModel {
  final String name;

  Nameable({required super.id, required this.name});
}
