import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config/key.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HttpApp();
}

class _HttpApp extends State<HttpApp> {
  String result = '';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Example'),
      ),
      body: Container(
        child: Center(
          child: Text('$result'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: () {
          getJsonData();
        },
      ),
    );
  }
  Future<String> getJsonData() async{
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&query=doit';
    var kakaoApiKey = AuthKey.kakaoApiKey;
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization":"KakaoAK $kakaoApiKey"
      }
    );
    print(response.body);
    return "Sucessfull";
  }
}