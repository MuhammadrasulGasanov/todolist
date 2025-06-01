import 'package:dio/dio.dart';
import 'package:todolist/data/models/category.dart';
import 'package:todolist/data/models/task.dart';

class TodoApi {
  final Dio _dio;

  TodoApi(this._dio) {
    _dio.options.baseUrl = 'http://localhost:3000';
  }

  Future<List<Task>> fetchTasks(String? filter) async {
    final response = await _dio.get('/tasks');
    final data = (response.data as List).map((t) => Task.fromJson(t)).toList();
    if (filter == null) return data;
    final filteredData = data.where((t) => t.category == filter).toList();
    return filteredData;
  }

  Future<List<TaskCategory>> fetchCategories() async {
    final response = await _dio.get('/categories');
    final dynamicData = response.data as List<dynamic>;
    if (dynamicData.isEmpty) return [];
    final categories =
        dynamicData.map((c) => TaskCategory.fromJson(c)).toList();
    return categories;
  }

  Future<void> updateTask(String? id, Map<String, dynamic> data) async {
    if (id != null) {
      await _dio.patch('/tasks/$id', data: data);
    }
  }

  Future<void> deleteTask(String? id) async {
    if (id != null) {
      await _dio.delete('/tasks/$id');
    }
  }

  Future<void> deleteCategory(String? id) async {
    if (id != null) {
      await _dio.delete('/categories/$id');
    }
  }

  Future<void> addCategory(TaskCategory category) async {
    await _dio.post(
      '/categories',
      data: category.toJson(),
      options: Options(contentType: 'application/json'),
    );
  }

  Future<void> addTask(Task todo) async {
    await _dio.post('/tasks', data: todo.toJson());
  }
}
