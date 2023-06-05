import 'package:flutter/foundation.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/api/todo_api.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> fetchTodos() async {
    try {
      // Make API call to fetch todos
      List<Todo> fetchedTodos = await TodoApi.fetchTodos();
      _todos = fetchedTodos;
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Error fetching  to fetch todos: $error');
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      // Make API call to add todo
      Todo addedTodo = await TodoApi.addTodo(todo);
      _todos.add(addedTodo);
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Error adding todo: $error');
    }
  }

  Future<void> updateTodoCompletionStatus(Todo todo, bool completed) async {
    try {
      // Make API call to update todo completion status
      await TodoApi.updateTodoCompletionStatus(todo.id, completed);
      todo.completed = completed;
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Error updating todo completion status: $error');
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      // Make API call to delete todo
      await TodoApi.deleteTodo(todo.id);
      _todos.remove(todo);
      notifyListeners();
    } catch (error) {
      // Handle error
      print('Error deleting todo: $error');
    }
  }
}
