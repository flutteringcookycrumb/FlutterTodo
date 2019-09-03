import 'dart:io';

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

class _TodoListState extends State<TodoList> {
  var _todos = <Todo>[];
  final _biggerFont = const TextStyle(fontSize: 20.0);
  final _textFieldController = TextEditingController();
  int _selectedBottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {

    var navigationBar;
    var drawer;

    if (Platform.isIOS) {
      navigationBar = _buildBottomBar();
    }
    if (Platform.isAndroid) {
      drawer = _buildDrawer();
    }

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: _buildContainer(),
        drawer: drawer,
        bottomNavigationBar: navigationBar);
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
                todo.title = _textFieldController.text;
                todo.checked = false;
                _todos.add(todo);
                _textFieldController.clear();
              });
            },
            child: const Icon(Icons.add)));
  }

  Widget _buildTextField() {
    return new Expanded(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            child: TextField(controller: _textFieldController)));
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School'),
        ),
      ],
      currentIndex: _selectedBottomBarIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        setState(() {
          _selectedBottomBarIndex = index;
        });
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
          child: Text('Navigation'),
          decoration: BoxDecoration(
            color: Colors.blue,
          )),
      ListTile(
        title: Text('Home'),
        leading: Icon(Icons.home),
      ),
      ListTile(
        title: Text('Business'),
        leading: Icon(Icons.business),
      ),
      ListTile(
        title: Text('School'),
        leading: Icon(Icons.school),
      )
    ]));
  }
}
