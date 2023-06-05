import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/todo_provider.dart';
import 'package:todo_app/screens/todo_list_screen.dart';
import 'package:todo_app/screens/login_screen.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/todoList': (context) => TodoListScreen(),
          '/addTodo': (context) => AddTodoScreen(),
        },
      ),
    );
  }
}
