import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class TaskStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.absolute.path;
  }

  Future<File> get _tasksFile async {
    final path = await _localPath;
    return File('$path/tasks.json');
  }

  Future<String> readTasks() async {
    try {
      final file = await _tasksFile;
      String tasks = await file.readAsString();
      debugPrint("Lendo: $tasks");
      return tasks;
    } catch (e) {
      debugPrint("Lendo: null. " + e.toString());
      return null;
    }
  }

  Future<File> writeTasks(List _todoList) async {
    final file = await _tasksFile;
    final tasks = json.encode(_todoList);
    debugPrint("Salvando: $tasks");
    return file.writeAsString(tasks);
  }

  Future<File> cleanTasks() async {
    return writeTasks(List());
  }
}
