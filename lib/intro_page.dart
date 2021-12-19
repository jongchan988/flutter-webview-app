import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'main_database.dart';

class IntroPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage>{
  Widget logo = const Icon(
    Icons.info,
    size:50,
  );

  @override
  void initState(){
    super.initState();
    initData();
  }

  void initData() async{
    var dir = await getApplicationDocumentsDirectory();
    if(await File(dir.path + '/myimage.jpg').exists()){
      setState(() {
        logo = Image.file(
          File(dir.path + '/myimage.jpg'),
          height: 200,
          width: 200,
          fit: BoxFit.contain,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
           children: [
             logo,
             ElevatedButton(
               onPressed: (){
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                   return MyHomePage(title: '');
                 }));
               },
               child: Text('다음으로 가기'),
             )
           ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

}