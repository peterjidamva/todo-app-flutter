import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:todo_app/models/todo.dart';

class TodoApi {
  static const String baseUrl =
      'https://dev.hisptz.com/dhis2/api/dataStore/drift2';
  static const String username = 'admin';
  static const String password = 'district';

  static Future<List<Todo>> fetchTodos() async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = _basicAuthCredentials();

      final response = await dio.get('$baseUrl?fields=.');

      if (response.data != null) {
        final dynamic jsonResponse = response.data;
        final List<dynamic> entries = jsonResponse['entries'];

        return entries.map((entry) {
          final Map<String, dynamic> value = entry['value'];
          return Todo(
            id: value['id'],
            title: value['title'],
            description: value['description'],
            completed: value['completed'],
            created: value['created'],
            lastUpdated: value['lastUpdated'],
          );
        }).toList();
      } else {
        throw Exception('Failed to fetch todos');
      }
    } catch (error) {
      throw Exception('Error fetching todos: $error');
    }
  }

  static Future<Todo> addTodo(Todo todo) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = _basicAuthCredentials();

      final response = await dio.post(
        '$baseUrl/${todo.id}',
        data: todo.toJson(),
      );

      if (response.statusCode == 200) {
        final dynamic json = response.data;
        return json;
      } else {
        throw Exception('Failed to add todo');
      }
    } catch (error) {
      throw Exception('Error adding todo: $error');
    }
  }

  static Future<String> editTodo(Todo todo) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = _basicAuthCredentials();

      final response = await dio.put(
        '$baseUrl/${todo.id}',
        data: todo.toJson(),
      );


      if (response.statusCode == 200) {
       
        Map<String, dynamic> jsonResponse = jsonDecode(response.data);

        return jsonResponse['status'];
      } else {
        throw Exception('Failed to add todo');
      }
    } catch (error) {
      throw Exception('Error adding todo: $error');
    }
  }

  static Future<String> updateTodoCompletionStatus(
      Todo todo, bool completed) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = _basicAuthCredentials();

      final response = await dio.put(
        '$baseUrl/${todo.id}',
        data: todo.toJson(),
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.data);

      if (response.statusCode != 200) {
        throw Exception('Failed to update todo completion status');
      } else {
        return jsonResponse['status'];
      }
    } catch (error) {
      throw Exception('Error updating todo completion status: $error');
    }
  }

  static Future<void> deleteTodo(String todoId) async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = _basicAuthCredentials();

      final response = await dio.delete('$baseUrl/$todoId');

      if (response.statusCode != 204) {
        throw Exception('Failed to delete todo');
      }
    } catch (error) {
      throw Exception('Error deleting todo: $error');
    }
  }

// ...

  static Future<List<Todo>> fetchCompletedTodos() async {
    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = _basicAuthCredentials();

      final response = await dio.get('$baseUrl?fields=.');

      if (response.data != null) {
        final dynamic jsonResponse = response.data;
        final List<dynamic> entries = jsonResponse['entries'];

        final completedEntries = entries.where((entry) {
          final Map<String, dynamic> value = entry['value'];
          return value['completed'] == true;
        }).toList();

        return completedEntries.map((entry) {
          final Map<String, dynamic> value = entry['value'];
          return Todo(
            id: value['id'],
            title: value['title'],
            description: value['description'],
            completed: value['completed'],
            created: value['created'],
            lastUpdated: value['lastUpdated'],
          );
        }).toList();
      } else {
        throw Exception('Failed to fetch todos');
      }
    } catch (error) {
      throw Exception('Error fetching todos: $error');
    }
  }

  static String _basicAuthCredentials() {
    const usernamePassword = '$username:$password';
    final credentials = utf8.encode(usernamePassword);
    final base64Credentials = base64.encode(credentials);
    return 'Basic $base64Credentials';
  }
}
