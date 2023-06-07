import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/edit_task_bottom_sheet.dart';
import 'package:todo_app/functions/functions.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';

class TodoPage extends StatelessWidget {
  final Todo todo;
  const TodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    void closePage() {
      Navigator.of(context).pop();
    }

    final snackBar = SnackBar(
      content: const Text('Deleted successfully!'),
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

    Future<void> confirmDeletion() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Delete task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            InkWell(
              onTap: () async {
                int response = await provider.deleteTodo(todo);
                closePage();
                if (response == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(failedSnackbar);
                }
                closePage();
              },
              child: const Text("Yes"),
            ),
            const Padding(padding: EdgeInsets.only(right: 15)),
            InkWell(
              onTap: () {
                closePage();
              },
              child: const Text("No"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () => closePage(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => Wrap(children: [
                      EditTaskBottomSheet(
                        todo: todo,
                      )
                    ]),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  confirmDeletion();
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Visibility(
              visible: todo.description.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  todo.description,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: todo.created.isNotEmpty,
                  child: Column(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey),
                      const SizedBox(height: 8.0),
                      const Text("createdAt",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 8.0),
                      Text(
                        getTimeAgo(todo.created),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: todo.lastUpdated != null,
                  child: Column(
                    children: [
                      const Icon(Icons.update, color: Colors.grey),
                      const SizedBox(height: 8.0),
                      const Text("updatedAt",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 8.0),
                      Text(
                        getTimeAgo(todo.lastUpdated!),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
