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
}