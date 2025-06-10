import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolist/utils.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@freezed
sealed class Task with _$Task {
  factory Task({
    // ignore_for_file: invalid_annotation_target
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(toJson: trim) required String title,
    @JsonKey(toJson: trim) String? description,
    @Default(false) bool completed,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'due_date') DateTime? dueDate,
  }) = _Task;
  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
}
