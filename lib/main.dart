import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(title: 'Todos'),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TodoListState createState() => _TodoListState();
}

class Todo {
  String title;
  bool checked;
}

class _TodoListState extends State<TodoList> {
  final _todos = <Todo>[];
  final _biggerFont = const TextStyle(fontSize: 20.0);
  String _textFieldValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return SafeArea(
        child: Column(children: [_buildList(), _buildAddTodoRow()]));
  }

  Widget _buildList() {
    return new Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(1),
            itemCount: _todos.length,
            itemBuilder: (context, i) {
              return _buildTodoRow(_todos[i]);
            }));
  }

  Widget _buildAddTodoRow() {
    return Row(children: [_buildTextField(), _buildAddTodoButton()]);
  }

  Widget _buildAddTodoButton() {
    return new Padding(
        padding: EdgeInsets.all(10),
        child: RaisedButton(
            onPressed: () {
              setState(() {
                Todo todo = new Todo();
                todo.title = _textFieldValue;
                todo.checked = false;
                _todos.add(todo);
              });
            },
            child: const Text('Add', style: TextStyle(fontSize: 20))));
  }

  Widget _buildTextField() {
    return new Expanded(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: TextField(onChanged: (text) {
              _textFieldValue = text;
            })));
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
}
