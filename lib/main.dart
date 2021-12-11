import 'package:flutter/material.dart';
import 'sub/first_page.dart';
import 'sub/second_page.dart';
import 'animal_item.dart';

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
  List<Animal> animalList = new List.empty(growable: true);
  
  @override
  void initState(){
    super.initState();
    controller = TabController(length: 2, vsync: this);
    animalList.add(Animal(
      animalName: '벌',
      kind: '곤충',
      imagePath: 'repo/images/bee.png'
    ));
    animalList.add(Animal(
        animalName: '고양이',
        kind: '류',
        imagePath: 'repo/images/cat.png'
    ));
    animalList.add(Animal(
        animalName: '젖소',
        kind: '포유류',
        imagePath: 'repo/images/cow.png'
    ));
    animalList.add(Animal(
        animalName: '강아지',
        kind: '포유류',
        imagePath: 'repo/images/dog.png'
    ));
    animalList.add(Animal(
        animalName: '여우',
        kind: '포유류',
        imagePath: 'repo/images/fox.png'
    ));
    animalList.add(Animal(
        animalName: '원숭이',
        kind: '영장류',
        imagePath: 'repo/images/monkey.png'
    ));
    animalList.add(Animal(
        animalName: '돼지',
        kind: '포유류',
        imagePath: 'repo/images/pig.png'
    ));
    animalList.add(Animal(
        animalName: '늑대',
        kind: '포유류',
        imagePath: 'repo/images/wolf.png'
    ));
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
        title: Text('Listview Example'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(list: animalList),
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
