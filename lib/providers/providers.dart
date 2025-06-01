import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolist/data/models/category.dart';
import 'package:todolist/data/models/task.dart';
import 'package:todolist/data/todo_api.dart';
import 'package:todolist/providers/categories_list_notifier.dart';
import 'package:todolist/providers/to_do_list_notifier.dart';

final dioProvider = Provider((ref) => Dio());

final todoApiProvider = Provider((ref) => TodoApi(ref.watch(dioProvider)));
final categoriesNotifierProvider = StateNotifierProvider<
  CategoriesListNotifier,
  AsyncValue<List<TaskCategory?>>
>((ref) => CategoriesListNotifier(ref.watch(todoApiProvider), ref));

final filterProvider = StateProvider<TaskCategory?>((ref) => null);

final todoListNotifierProvider =
    StateNotifierProvider<TodoListNotifier, AsyncValue<List<Task>>>(
      (ref) => TodoListNotifier(ref.watch(todoApiProvider)),
    );
