import 'package:flutter/material.dart';
import 'sub/first_page.dart';
import 'sub/second_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = "Widget Example";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  TabController? controller;

  @override
  void initState(){
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    controller!.addListener(() {
      if(!controller!.indexIsChanging){
        print("이전 index , ${controller!.previousIndex}");
        print("현재 index , ${controller!.index}");
      }
    });
    return Scaffold(
      appBar: AppBar(
          title: Text('Tabbar Example'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(),
          SecondApp(),
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(
              Icons.ac_unit_sharp,
              color: Colors.blue,
            )
          ),
          Tab(
              icon: Icon(
                Icons.access_alarm,
                color: Colors.blue,
              )
          ),
        ],controller:controller,
      ),
    );
  }
}
