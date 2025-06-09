import 'package:dio/dio.dart';
import 'package:todolist/data/models/auth_request.dart';
import 'package:todolist/data/models/auth_response.dart';
import 'package:todolist/data/models/category.dart';
import 'package:todolist/data/models/task.dart';
import 'package:todolist/main.dart';

class TodoApi {
  final Dio _dio;

  TodoApi(this._dio) {
    _dio.options.baseUrl = 'http://185.173.94.122:8080';
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (!options.path.contains('/login') &&
              !options.path.contains('/register')) {
            final token = sharedPrefs.getString('token');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<Task>> fetchTasks(String? filter) async {
    final response = await _dio.get('/tasks');
    late final List<Task> data;
    if (response.data == null) {
      data = [];
    } else {
      try {
        data = (response.data as List).map((t) => Task.fromJson(t)).toList();
      } catch (_) {}
    }
    if (filter == null) return data;
    final filteredData = data.where((t) => t.category == filter).toList();
    return filteredData;
  }

  Future<List<TaskCategory>> fetchCategories() async {
    final response = await _dio.get('/categories');
    late final List<TaskCategory> categories;
    if (response.data == null) {
      categories = [];
    } else {
      try {
        categories =
            (response.data as List)
                .map((c) => TaskCategory.fromJson(c))
                .toList();
      } catch (_) {}
    }
    return categories;
  }

  Future<void> updateTask(int? id, Task data) async {
    if (id != null) {
      await _dio.put('/tasks/$id', data: data.toJson());
    }
  }

  Future<void> markTaskCompletion(int? id, bool value) async {
    if (id != null) {
      await _dio.patch('/tasks/$id', data: {'completed': value});
    }
  }

  Future<void> deleteTask(int? id) async {
    if (id != null) {
      await _dio.delete('/tasks/$id');
    }
  }

  Future<void> deleteCategory(int? id) async {
    if (id != null) {
      await _dio.delete('/categories/$id');
    }
  }

  Future<void> addCategory(TaskCategory category) async {
    try {
      await _dio.post(
        '/categories',
        data: category.toJson(),
        options: Options(contentType: 'application/json'),
      );
    } catch (_) {}
  }

  Future<AuthResponse?> login(AuthRequest request) async {
    final response = await _dio.post('/login', data: request.toJson());
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse?> registration(AuthRequest request) async {
    final response = await _dio.post('/register', data: request.toJson());
    return AuthResponse.fromJson(response.data);
  }

  Future<void> addTask(Task todo) async {
    await _dio.post('/tasks', data: todo.toJson());
  }
}
