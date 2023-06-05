import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo.dart';

class TodoApi {
  static const String baseUrl =
      'https://dev.hisptz.com/dhis2/api/dataStore/drift';
  static const String username = 'admin';
  static const String password = 'district';

  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(
      Uri.parse('$baseUrl?fields=.'),
      headers: {'Authorization': _basicAuthCredentials()},
    );
    print(response);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  static Future<Todo> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/${todo.id}'),
      body: json.encode(todo.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': _basicAuthCredentials()
      },
    );

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      return Todo.fromJson(json);
    } else {
      throw Exception('Failed to add todo');
    }
  }

  static Future<void> updateTodoCompletionStatus(
      String todoId, bool completed) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$todoId'),
      body: json.encode({'completed': completed}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': _basicAuthCredentials()
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo completion status');
    }
  }

  static Future<void> deleteTodo(String todoId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$todoId'),
      headers: {'Authorization': _basicAuthCredentials()},
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete todo');
    }
  }

  static String _basicAuthCredentials() {
    const usernamePassword = '$username:$password';
    final credentials = utf8.encode(usernamePassword);
    final base64Credentials = base64.encode(credentials);
    return 'Basic $base64Credentials';
  }
}
