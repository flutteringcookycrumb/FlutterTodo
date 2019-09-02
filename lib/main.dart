import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Todo {
  String title;
  bool checked;
}

  class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(title: 'To Do\'s'),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoListState createState() => new _TodoListState();
}


class  _TodoListState extends State<TodoList> {
  var _todos = <Todo>[];
  final _biggerFont = const TextStyle(fontSize: 20.0);
  String _textFieldValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: _buildContainer());
  }

  Widget _buildContainer() {
    return SafeArea(
        child: Column(children: [_buildList(), _buildAddTodoRow()]));
  }

  Widget _buildList() {
    return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(1),
            itemCount: _todos.length,
            itemBuilder: (context, i) {
              return _buildTodoRow(_todos[i]);
            }));
  }


  Widget _buildTodoRow(Todo todo) {
    return ListTile(
      title: Text(todo.title, style: _biggerFont),
      trailing:
      Icon(todo.checked ? Icons.check_box : Icons.check_box_outline_blank),
      onTap: () {
        setState(() {
          todo.checked = !todo.checked;
        });
      },
    );
  }

  Widget _buildAddTodoRow() {
    return Row(children: [_buildTextField(), _buildAddTodoButton()]);
  }

  Widget _buildAddTodoButton() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
            onPressed: () {
              setState(() {
                Todo todo = Todo();
                todo.title = _textFieldValue;
                todo.checked = false;
                _todos.add(todo);
              });
            },
            child: const Icon(Icons.add)));
  }

  Widget _buildTextField() {
    return new Expanded(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: TextField(onChanged: (text) {
              _textFieldValue = text;
            })));
  }

}
