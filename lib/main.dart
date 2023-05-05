import 'package:flutter/material.dart';
import 'package:todo_app/ToDoPage.dart';
import 'package:todo_app/route_generator.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const  ToDoPage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generatorRoute,

    );
  }
}
