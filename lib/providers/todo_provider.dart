import 'package:flutter/foundation.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/api/todo_api.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    try {
      List<Todo> fetchedTodos = await TodoApi.fetchTodos();
      _todos = fetchedTodos;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching  to fetch todos: $error');
      }
    }
  }

  Future<void> editTodo(Todo todo) async {
    try {
      String addedTodo = await TodoApi.editTodo(todo);
      if (addedTodo == "200") {
        notifyListeners();
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error adding todo: $error');
      }
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
     await TodoApi.addTodo(todo);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error adding todo: $error');
      }
    }
  }

  Future<void> updateTodoCompletionStatus(Todo todo, bool completed) async {
    try {
      todo.completed = completed;
      todo.lastUpdated = DateTime.now().toString();
      await TodoApi.updateTodoCompletionStatus(todo, completed);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error updating todo completion status: $error');
      }
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      await TodoApi.deleteTodo(todo.id);
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting todo: $error');
      }
    }
  }
}
