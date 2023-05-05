import 'package:flutter/material.dart';
import 'package:todo_app/ListPage.dart';
import 'package:todo_app/ToDoPage.dart';
import 'package:todo_app/main.dart';
class RouteGenerator{
  static Route<dynamic> generatorRoute(RouteSettings settings){
    final args= settings.arguments;
    switch(settings.name){
      case'/':
        return MaterialPageRoute(builder: (_)=>const ToDoPage());
      case'/second':
        return MaterialPageRoute(builder: (_)=>const ListPage());
      default:
        return errorPage();
    }
  }

  static Route<dynamic> errorPage() {
    return  MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error Page"),
        ),
        body: const Center(child: Text("There is an Error", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),),
      );
    });
  }
}