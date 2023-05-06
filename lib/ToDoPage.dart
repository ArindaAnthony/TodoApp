import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  List items = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final id = item['_id'];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        //Open edit page
                        navigateToEditPage();

                      } else if (value == 'delete') {
                        //delete
                        deletebyId(id);
                      }
                    },
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text("Edit"),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            "Delete",
                          ),
                        ),
                      ];
                    },
                  ),
                );
              }),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamed('/second');
          },
          label: const Text("Add Todo")),
    );
  }

  Future<void> fetchData() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
      showSuccessMessage("Creation Successful");
    } else {
      showErrorMessage("Creation Failed");
    }
    setState(() {
      isLoading = false;
    });
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> deletebyId(String id)async {
    //delete the item
    final url= 'https://api.nstack.in/v1/todos/$id';
    final uri=Uri.parse(url);
    final response=await http.delete(uri);
    if (response.statusCode==200) {
      //remove item from list
      final filtered= items.where((element) => element['_id']!=id,).toList();
      setState(() {
        items=filtered;
      });
    }  else{
      //display failure message
      showErrorMessage("Delete failed");
    }

  }

  Future<void> navigateToEditPage() async {
    Navigator.of(context).pushNamed('/second');
  }
}
