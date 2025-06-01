import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/task.dart';
import 'package:todolist/data/todo_api.dart';

class TodoListNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final TodoApi api;

  TodoListNotifier(this.api) : super(AsyncLoading()) {
    _loadTasks();
  }

  Future<void> _loadTasks([String? filter]) async {
    state = const AsyncLoading();
    try {
      final tasks = await api.fetchTasks(filter);
      state = AsyncData(tasks);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void refresh([String? filter]) async => await _loadTasks(filter);

  Future<void> delete(String? id) async {
    if (id != null && state.value != null) {
      final updated = state.value!.where((t) => t.id != id).toList();
      state = AsyncData(updated);
      try {
        await api.deleteTask(id);
        await _loadTasks();
      } catch (e, st) {
        state = AsyncError(e, st);
      }
    }
  }

  Future<void> markCompleted(String? id, bool value) async {
    if (id != null && state.value != null) {
      final updated =
          state.value!.map((t) {
            return t.id == id ? t.copyWith(completed: value) : t;
          }).toList();
      state = AsyncData(updated);
      try {
        await api.updateTask(id, {'completed': value});
        await _loadTasks();
      } catch (e, st) {
        state = AsyncError(e, st);
      }
    }
  }
}
