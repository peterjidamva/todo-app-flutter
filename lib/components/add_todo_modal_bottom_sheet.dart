import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:uuid/uuid.dart';

class AddTaskModalBottomSheet extends StatefulWidget {
  const AddTaskModalBottomSheet({super.key});

  @override
  State<AddTaskModalBottomSheet> createState() =>
      _AddTaskModalBottomSheetState();
}

class _AddTaskModalBottomSheetState extends State<AddTaskModalBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    ThemeData themeData = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
    );

    final snackBar = SnackBar(
      content: const Text('Todo added successfully!'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green, // Customize the background color
      elevation: 6, // Customize the elevation
      behavior: SnackBarBehavior.floating, // Make it floating
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add border radius
      ),
     
    );

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 40, left: 40),
      child: Column(children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
          ),
          style: const TextStyle(fontSize: 12),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: "Description"),
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              final String title = titleController.text.trim();
              final String description = descriptionController.text.trim();

              if (title.isNotEmpty && description.isNotEmpty) {
                final Todo newTodo = Todo(
                  id: Uuid().v4(),
                  title: title,
                  description: description,
                  completed: false,
                  created: DateTime.now().toString(),
                  lastUpdated: DateTime.now().toString(),
                );

                Provider.of<TodoProvider>(context, listen: false)
                    .addTodo(newTodo);
                // Show the success message at the bottom of the screen

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              }
            },
            child: const Text("Add"),
          ),
        ),
      ]),
    );
  }
}
