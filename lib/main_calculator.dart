import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = "Widget Example";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget{
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp>{
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  final List _buttonList = [
    '더하기',
    '빼기',
    '곱하기',
    '나누기'
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List.empty(growable: true);
  String? _buttonText;

  @override
  void initState(){
    super.initState();
    for(var item in _buttonList){
      _dropDownMenuItems.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        )
      );
    }
  }

  IconData getIconData(){
    switch(_buttonText){
      case "더하기" :
        return Icons.add;
      case "빼기" :
        return Icons.eleven_mp_rounded;
      case "곱하기" :
        return Icons.eighteen_mp;
      case "나누기" :
        return Icons.ten_k;
    }
    return Icons.add;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text('flutter'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20,
                    right: 20
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: value2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(getIconData()),
                      Text(_buttonText!)
                    ],
                  ),
                  onPressed: (){
                    setState(() {
                      var value1Int = double.parse(value1.value.text);
                      var value2Int = double.parse(value2.value.text);
                      var result;

                      switch(_buttonText){
                        case '더하기':
                          result = value1Int + value2Int;
                          break;
                        case '빼기':
                          result = value1Int - value2Int;
                          break;
                        case '곱하기':
                          result = value1Int * value2Int;
                          break;
                        case '나누기':
                          result = value1Int / value2Int;
                          break;
                        default:
                          result = "정의되어있지 않음 ($_buttonText)";
                      }
                      sum = '$result';
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  '결과 : $sum',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: DropdownButton(
                  items: _dropDownMenuItems,
                  onChanged: (String? value){
                   setState(() {
                     _buttonText = value;
                   });
                  }, value: _buttonText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}