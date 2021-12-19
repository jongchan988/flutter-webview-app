import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file_app.dart';
import 'large_file_main.dart';
import 'intro_page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_app.dart';
import 'add_todo.dart';
import 'clear_list_app.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(database),
        '/add': (context) => AddTodoApp(database),
        '/clear': (context) => ClearListApp(database)
      },
    );
  }

  Future<Database> initDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), 'todo_databse.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, active INTEGER)",
        );
      },
      version: 1,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState(){
    super.initState();
    _loadData();
  }
  void _setData(int value) async{
    var key = 'count';
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  void _loadData() async{
    var key = 'count';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getInt(key);
      if (value == null){
        _counter = 0;
      } else {
        _counter = value;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _setData(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로고바꾸기'),
        actions: <Widget>[
          TextButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LargeFileMain()));
            },
            child: Text(
              '로고 바꾸기',
              style: TextStyle(color: Colors.white),
            )
          )
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}