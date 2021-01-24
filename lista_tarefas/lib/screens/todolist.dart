import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/io/task_storage.dart';
import 'package:uuid/uuid.dart';

class TodoListApp extends StatefulWidget {
  final String title;
  final TaskStorage storage;

  TodoListApp({Key key, this.title, @required this.storage}) : super(key: key);

  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  final taskInputController = TextEditingController();
  final uuid = Uuid();
  List _todoList = [];
  Map<String, Object> lastItemRemoved = {};

  @override
  void initState() {
    super.initState();
    widget.storage.readTasks().then(
          (data) => {
            setState(() {
              if (data == null) {
                _todoList = List();
                return;
              }
              _todoList = json.decode(data);
            })
          },
        );
  }

  @override
  Widget build(BuildContext widgetContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _onPressedButtonCleanTodoList(widgetContext),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskInputController,
                    decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: _onPressedButtonAddToDo,
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _sortTasks,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _todoList.length,
                itemBuilder: _buildListItem,
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildListItem(BuildContext listItemContext, int index) {
    return Dismissible(
      key: Key(_todoList[index]["id"]),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) =>
          _onDismissedCheckboxListItem(listItemContext, index),
      child: CheckboxListTile(
          title: Text(_todoList[index]["title"]),
          value: _todoList[index]["ok"],
          secondary: CircleAvatar(
            child: Icon(_todoList[index]["ok"] ? Icons.check : Icons.error),
          ),
          onChanged: (bool value) => _onChangedCheckboxListItem(value, index)),
    );
  }

  void _onPressedButtonAddToDo() {
    if (taskInputController.text.isEmpty) return;

    setState(() {
      final newTask = {
        "id": uuid.v4(),
        "title": taskInputController.text,
        "ok": false
      };

      _todoList.add(newTask);
    });
    widget.storage.writeTasks(_todoList);
    taskInputController.clear();
  }

  void _onPressedButtonCleanTodoList(BuildContext widgetContext) {
    if (_todoList.isEmpty) {
      final snackbar = SnackBar(
        content: Text("Nenhum item para remover!"),
        duration: Duration(seconds: 2),
      );

      Scaffold.of(widgetContext).removeCurrentSnackBar();
      Scaffold.of(widgetContext).showSnackBar(snackbar);
    } else {
      Widget okButton = FlatButton(
        child: Text(
          "Limpar",
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          widget.storage.cleanTasks();
          setState(() {
            _todoList.clear();
          });
          Navigator.pop(context, false);
        },
      );
      Widget cancelButton = FlatButton(
        child: Text("Cancelar"),
        onPressed: () {
          Navigator.pop(context, true);
        },
      );

      showDialog(
          context: widgetContext,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notice"),
              content: Text("Deseja limpar sua lista de Tarefas?"),
              actions: [cancelButton, okButton],
            );
          });

      taskInputController.clear();
    }
  }

  void _onChangedCheckboxListItem(bool value, int index) {
    setState(() {
      _todoList[index]["ok"] = value;
    });
    widget.storage.writeTasks(_todoList);
  }

  void _onDismissedCheckboxListItem(BuildContext listItemContext, int index) {
    this.lastItemRemoved = _todoList[index];
    setState(() {
      _todoList.removeAt(index);
    });
    widget.storage.writeTasks(_todoList);

    final snackbar = SnackBar(
      content: Text("Tarefa \"${this.lastItemRemoved["title"]}\" removida!"),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          setState(() {
            _todoList.insert(index, this.lastItemRemoved);
            this.lastItemRemoved = {};
          });
          widget.storage.writeTasks(_todoList);
        },
      ),
    );

    Scaffold.of(listItemContext).removeCurrentSnackBar();
    Scaffold.of(listItemContext).showSnackBar(snackbar);
  }

  Future<Null> _sortTasks() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _todoList.sort((taskA, taskB) {
        if (taskA["ok"] && !taskB["ok"])
          return 1;
        else if (!taskA["ok"] && taskB["ok"])
          return -1;
        else
          return 0;
      });
    });

    widget.storage.writeTasks(_todoList);
  }
}
