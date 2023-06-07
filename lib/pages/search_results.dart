import 'package:flutter/material.dart';
import 'package:todo_app/components/todo_card.dart';
import 'package:todo_app/models/todo.dart';

class SearchResultsPage extends StatelessWidget {
  final String task;
  List<Todo> todos = [];
  SearchResultsPage({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    List<Todo> searchResults = todos
        .where((todo) => todo.title.toLowerCase().contains(task.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: " ",
            children: [
              TextSpan(
                text: task,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Visibility(
              replacement: const Center(
                child: Text("No item found"),
              ),
              visible: searchResults.isNotEmpty,
              child: Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) =>
                      TodoCard(todo: searchResults[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
