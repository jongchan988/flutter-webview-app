import 'package:flutter/material.dart';
import 'large_file_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: LargeFileMain(),
    );
  }
}