import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';

class EditTaskModal extends StatefulWidget {
  final Todo todo;

  const EditTaskModal({Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTaskModal> createState() => _EditTaskModalState();
}

class _EditTaskModalState extends State<EditTaskModal> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TodoProvider todoProvider;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController =
        TextEditingController(text: widget.todo.description);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    todoProvider = Provider.of<TodoProvider>(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context).copyWith(
      colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
    );

    final snackBar = SnackBar(
      content: const Text('Todo edited successfully!'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final failedSnackbar = SnackBar(
      content: const Text('Failed!'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 40, left: 40),
        child: Column(
          children: [
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
                onPressed: () async {
                  final String title = titleController.text.trim();
                  final String description = descriptionController.text.trim();

                  if (title.isNotEmpty && description.isNotEmpty) {
                    final Todo newTodo = Todo(
                      id: widget.todo.id,
                      title: title,
                      description: description,
                      completed: widget.todo.completed,
                      created: widget.todo.created,
                      lastUpdated: DateTime.now().toString(),
                    );

                    titleController.clear();
                    descriptionController.clear();

                    int response = await todoProvider.editTodo(newTodo);

                    if (response == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(failedSnackbar);
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
