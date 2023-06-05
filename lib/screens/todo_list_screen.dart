import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_provider.dart';
import 'package:todo_app/models/todo.dart';

class TodoListScreen extends StatelessWidget {
  void navigateToAddTodoScreen(BuildContext context) {
    Navigator.pushNamed(context, '/addTodo');
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final List<Todo> todos = todoProvider.todos;

    print(todoProvider.todos);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            trailing: Checkbox(
              value: todo.completed,
              onChanged: (value) {
                // Update the completion status of the todo
                // Call the appropriate method in TodoProvider
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddTodoScreen(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
