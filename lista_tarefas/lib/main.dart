import 'package:flutter/material.dart';
import 'package:lista_tarefas/io/task_storage.dart';
import 'package:lista_tarefas/screens/todolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListApp(
        title: 'Lista de Tarefas',
        storage: TaskStorage(),
      ),
    );
  }
}
