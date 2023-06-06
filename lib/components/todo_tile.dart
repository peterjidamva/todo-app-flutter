import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/functions/functions.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/todo.dart';
import 'package:todo_app/providers/todo_provider.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;
  const TodoTile({super.key, required this.todo});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('status updated successfully!'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green, // Customize the background color
      elevation: 6, // Customize the elevation
      behavior: SnackBarBehavior.floating, // Make it floating
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add border radius
      ),
    );

    final provider = Provider.of<TodoProvider>(context);
    final todo = widget.todo;

    return GestureDetector(
      onTap: () {
        // Perform navigation to the next widget
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TodoPage(
                    todo: todo,
                  )),
        );
      },
      child: SizedBox(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                  backgroundColor: todo.completed ? Colors.green : Colors.grey,
                  radius: 40,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const Spacer(),
                    Text(
                      getTimeAgo(todo.created),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Tooltip(
                  message: "Update Status",
                  child: IconButton(
                    icon: Icon(
                      Icons.check_box,
                      color: todo.completed ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      provider.updateTodoCompletionStatus(
                          todo, !todo.completed);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {});
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
