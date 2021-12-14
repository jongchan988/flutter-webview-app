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
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page = 1;

  @override
  void initState(){
    super.initState();
    data = new List.empty(growable: true);
    _editingController = new TextEditingController();
    _scrollController = new ScrollController();

    _scrollController!.addListener(() {
      if(needData()){
        page++;
        getJsonData();
      }
    });
  }

  bool needData() => _scrollController!.offset >= _scrollController!.position.maxScrollExtent && !_scrollController!.position.outOfRange;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(
            color: Colors.white
          ),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요'
          ),
        ),
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
                  child: Row(
                    children : <Widget>[
                      Image.network(
                        data![index]['thumbnail'],
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              data![index]['title'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text('저자 : ${data![index]['authors'].toString()}'),
                          Text('가격 : ${data![index]['sale_price'].toString()}'),
                          Text('판매중 : ${data![index]['status'].toString()}'),
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
              );
            },
            itemCount: data!.length,
            controller: _scrollController,
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: () {
          page = 1;
          data!.clear();
          getJsonData();
        },
      ),
    );
  }
  Future<String> getJsonData() async{
    var url = 'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController!.value.text}';
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