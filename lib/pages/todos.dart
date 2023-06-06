import 'package:flutter/material.dart';
import 'package:todo_app/api/todo_api.dart';
import 'package:todo_app/components/add_todo_modal_bottom_sheet.dart';
import 'package:todo_app/components/loading.dart';
import 'package:todo_app/components/search_bar.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/models/todo.dart';


class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
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
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new task",
        backgroundColor: primaryColor,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) =>
              Wrap(children: const [AddTaskModalBottomSheet()]),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           SearchBar(alltodos:todos,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: isLoading
                  ? LoadingScreen()
                  : Visibility(
                      replacement: const Center(
                        child: Text("You have not added any tasks"),
                      ),
                      visible: todos.isNotEmpty,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: todos.length,
                        itemBuilder: (context, index) => Column(
                              children: [
                                TodoTile(todo: todos[index]),
                                const Divider(),
                              ],
                            )),
                  ),
            ),
          ),
        ]),
      ),
    );
  }
}
