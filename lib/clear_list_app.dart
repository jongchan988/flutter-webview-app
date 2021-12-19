import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'entity/sqflite/todo.dart';

class ClearListApp extends StatefulWidget{
  Future<Database> database;
  ClearListApp(this.database);

  @override
  State<StatefulWidget> createState() => _ClearListApp();
}

class _ClearListApp extends State<ClearListApp>{
  Future<List<Todo>>? clearList;

  @override
  void initState(){
    super.initState();
    clearList = getClearList();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('완료한 일'),
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
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
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
            future: clearList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final result = await showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text('완료한 일 삭제'),
                content: Text('완료한 일을 모두 삭제할까요?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop(true);
                    },
                    child: Text('예'),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop(false);
                    },
                    child: Text('아니요'),
                  ),
                ],
              );
            }
          );
          if(result == true){
            _removeAllTodos();
          }
        },
        child: Icon(Icons.remove),
      ),
    );
  }

  Future<List<Todo>> getClearList() async{
    final Database database = await widget.database;
    String getClearListQuery = 'select title, content, id from todos where active=1';
    List<Map<String, dynamic>> maps = await database.rawQuery(getClearListQuery);
    return List.generate(maps.length, (index){
      return Todo(
        title: maps[index]['title'].toString(),
        content: maps[index]['content'].toString(),
        id: maps[index]['id']
      );
    });
  }

  void _removeAllTodos () async{
    final Database database = await widget.database;
    database.rawDelete('delete from todos where active=1');
    setState(() {
      clearList = getClearList();
    });
  }
}