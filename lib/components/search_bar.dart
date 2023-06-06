import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/search_results.dart';

class SearchBar extends StatefulWidget {
  List<Todo> alltodos = [];
   SearchBar({super.key,required this.alltodos});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              controller.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultsPage(task: value.trim(),todos: widget.alltodos),
                ),
              );
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
                label: Text(
                  "Search",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                )),
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
