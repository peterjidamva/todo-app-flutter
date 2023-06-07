import 'package:flutter/material.dart';
import 'package:todo_app/api/todo_api.dart';
import 'package:todo_app/components/loading.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/models/todo.dart';

class CompletedTodosPage extends StatefulWidget {
  const CompletedTodosPage({super.key});

  @override
  State<CompletedTodosPage> createState() => _CompletedTodosPageState();
}

class _CompletedTodosPageState extends State<CompletedTodosPage> {
  List<Todo> todos = [];

  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      List<Todo> fetchedTodos = await TodoApi.fetchTodos();
      setState(() {
        todos = fetchedTodos;
        isLoading =
            false; // Set isLoading to false once data fetching is finished
      });
    } catch (error) {
      print('Error fetching todos: $error');
      if (mounted) {
        // Prevent calling setState if widget is disposed
        setState(() {
          isLoading = false; // Set isLoading to false in case of an error
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Todo> completedTodos =
        todos.where((todo) => todo.completed == true).toList();

    return isLoading
        ? const LoadingScreen()
        : Visibility(
            replacement: const Center(
              child: Text("No task is Complete"),
            ),
            visible: completedTodos.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Completed ${completedTodos.length} tasks "),
                    const Divider(),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: completedTodos.length,
                        itemBuilder: (context, index) => TodoTile(
                          todo: completedTodos[index],
                        ),
                      ),
                    ),
                  ]),
            ),
          );
  }
}
