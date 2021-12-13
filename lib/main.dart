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
  List? data;

  @override
  void initState(){
    super.initState();
    data = new List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Example'),
      ),
      body: Container(
        child: Center(
          child: data!.length == 0 ?
          Text(
            '데이터가없습니다.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ):
          ListView.builder(
            itemBuilder: (context, index){
              return Card(
                child: Container(
                  child: Column(
                    children : <Widget>[
                      Text(data![index]['title'].toString()),
                      Text(data![index]['authors'].toString()),
                      Text(data![index]['sale_price'].toString()),
                      Text(data![index]['status'].toString()),
                      Image.network(
                        data![index]['thumbnail'],
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: data!.length,
          )
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
    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List documentsList = dataConvertedToJSON['documents'];
      data!.addAll(documentsList);
    });
    return response.body;
  }


}