import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/category.dart';
import 'package:todolist/data/todo_api.dart';

class CategoriesListNotifier
    extends StateNotifier<AsyncValue<List<TaskCategory?>>> {
  CategoriesListNotifier(this.api, this.ref) : super(const AsyncLoading()) {
    refresh();
  }
  final TodoApi api;
  final Ref ref;

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final categories = await api.fetchCategories();
      state = AsyncData(categories);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteCategory(TaskCategory? category) async {
    if (category == null) return;
    try {
      await api.deleteCategory(category.id);
      await refresh();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<TaskCategory?> addCategory(TaskCategory? category) async {
    if (state.value == null) return null;
    try {
      final allCategories = state.value!;
      bool contains = false;
      for (final c in allCategories) {
        if (c?.name == category?.name) contains = true;
      }
      final canPost = category != null && (allCategories.isEmpty || !contains);
      TaskCategory? data;
      if (canPost) data = await api.addCategory(category);
      await refresh();
      return data;
    } catch (e, st) {
      state = AsyncError(e, st);
      return null;
    }
  }
}
