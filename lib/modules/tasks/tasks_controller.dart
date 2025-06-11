import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/task.dart';
import 'package:todolist/main.dart';
import 'package:todolist/providers/providers.dart';
import 'package:todolist/router.gr.dart';
import 'package:todolist/widgets/drop_down_filters.dart';

final tasksControllerProvider = Provider((ref) => TasksController(ref));

class TasksController {
  final Ref _ref;

  TasksController(this._ref);

  Future<void> handleLogout(BuildContext context) async {
    await sharedPrefs.remove('token');
    if (context.mounted) {
      context.router.replaceAll([AuthRoute()]);
    }
  }

  Future<void> refreshTasks() async {
    await _ref.read(todoListNotifierProvider.notifier).refresh();
  }

  Future<void> handleTaskPress(Task? task, BuildContext context) async {
    final notifier = _ref.read(filterProvider.notifier);

    if (task?.categoryId != null) {
      notifier.state = await _ref
          .read(todoApiProvider)
          .fetchCategoryById(task?.categoryId);
    } else {
      notifier.state = null;
    }

    if (context.mounted) {
      context.pushRoute(
        TaskEditorRoute(task: task, dropDownMode: DropDownMode.editing),
      );
    }
  }

  Future<void> handleTaskCompletion(int? id, bool value) async {
    await _ref
        .read(todoListNotifierProvider.notifier)
        .markTaskCompletion(id, value);
  }

  Future<void> handleTaskDeletion(int? id) async {
    await _ref.read(todoListNotifierProvider.notifier).delete(id);
  }

  void navigateToNewTask(BuildContext context) {
    _ref.read(filterProvider.notifier).state = null;
    context.pushRoute(TaskEditorRoute());
  }
}
