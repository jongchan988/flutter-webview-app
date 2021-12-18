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
  Future<List<Todo>>? todoList;

  @override
  void initState(){
    super.initState();
    todoList = getTodos();
  }
  void _insertTodo(Todo todo) async{
    final Database database = await widget.db;
    await database.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async{
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async{
    final Database database = await widget.db;
    database.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todo.id]
    );
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (i){
      int active = maps[i]['active'] == 1 ? 1 : 0;
      return Todo(
        title: maps[i]['title'].toString(),
        content: maps[i]['content'].toString(),
        active: active,
        id: maps[i]['id']
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Database Example'
        ),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemBuilder: (context, index){
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: <Widget>[
                                Text(todo.content!),
                                Text('${todo.active == 1 ? 'true' : 'false'}'),
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          onLongPress: () async {
                            Todo result = await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('${todo.id} : ${todo.title}'),
                                  content: Text('${todo.content}를 삭제하시겠습니까?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('예'),
                                    )
                                    ,
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('아니요'),
                                    )
                                  ],
                                );
                              }
                            );
                            _deleteTodo(result);
                          },
                          onTap: () async {
                            TextEditingController controller = new TextEditingController(text: todo.content);
                            Todo result = await showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('${todo.id} : ${todo.title}'),
                                  content: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.text,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: (){
                                        todo.active == 1 ? todo.active = 0 : todo.active = 1;
                                        todo.content = controller.value.text;
                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('예(체크변경 o)'),
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        todo.active == 1 ? todo.active = 0 : todo.active = 1;
                                        todo.content = controller.value.text;
                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('예(체크변경 x)'),
                                    ),
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('아니요'),
                                    )
                                  ],
                                );
                              }
                            );
                            _updateTodo(result);
                          },
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  }else{
                    return Text('No Data');
                  }
              }
              return CircularProgressIndicator();
            },
            future: todoList,
          ),
        ),
      ),
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