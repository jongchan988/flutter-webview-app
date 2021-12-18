import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'entity/sqflite/todo.dart';

class DatabaseApp extends StatefulWidget{
  final Future<Database> db;
  DatabaseApp(this.db);
  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp>{
  void _insertTodo(Todo todo) async{
    final Database database = await widget.db;
    await database.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Database Example'
        ),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final todo = await Navigator.of(context).pushNamed('/add');
          if(todo != null){
            _insertTodo(todo as Todo);
          }
        },
        child: Icon(
          Icons.add
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}