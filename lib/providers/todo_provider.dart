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

  Future<int> editTodo(Todo todo) async {
    try {
      int addedTodo = await TodoApi.editTodo(todo);

      if (addedTodo == 200) {
        notifyListeners();
        return addedTodo;
      } else {
        return 0;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error adding todo: $error');
      }
      return -1;
    }
  }

  Future<int> addTodo(Todo todo) async {
    try {
      int addResponse = await TodoApi.addTodo(todo);

      if (addResponse == 201) {
        notifyListeners();
        return addResponse;
      } else {
        return 0;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error adding todo: $error');
      }
      return -1;
    }
  }

  Future<int> updateTodoCompletionStatus(Todo todo, bool completed) async {
    try {
      todo.completed = completed;
      todo.lastUpdated = DateTime.now().toString();
      int updateText =
          await TodoApi.updateTodoCompletionStatus(todo, completed);

      if (updateText == 200) {
        notifyListeners();
        return updateText;
      } else {
        return 0;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating todo completion status: $error');
      }
      return -1;
    }
  }

  Future<int> deleteTodo(Todo todo) async {
    try {
      int deletedText = await TodoApi.deleteTodo(todo.id);

      if (deletedText == 200) {
        notifyListeners();
        return deletedText;
      } else {
        return 0;
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting todo: $error');
      }
      return -1;
    }
  }
}
