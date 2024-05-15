import 'package:lexa/data/models/base.model.dart';

class SystemFolderTreeDto extends BaseModel {
  final String name;
  final List<dynamic> children;
  SystemFolderTreeDto({
    required super.id,
    this.name = "",
    this.children = const [],
  });
}
