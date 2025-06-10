import 'package:json_annotation/json_annotation.dart';
import 'package:todolist/utils.dart';

part 'category.g.dart';

@JsonSerializable()
class TaskCategory {
  @JsonKey(includeToJson: false)
  final int? id;

  @JsonKey(toJson: trim)
  final String name;

  TaskCategory({this.id, required this.name});

  factory TaskCategory.fromJson(Map<String, dynamic> json) =>
      _$TaskCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$TaskCategoryToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCategory &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
