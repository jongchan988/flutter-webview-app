import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CupertinoNativeApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CupertinoNative();
  }
}

class _CupertinoNative extends State<CupertinoNativeApp> {
  static const platform = const MethodChannel('com.flutter.dev/calc');

  TextEditingController num1Controller =
  TextEditingController(text: 0.toString());
  TextEditingController num2Controller =
  TextEditingController(text: 0.toString());
  int? _result;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                CupertinoTextField(
                  controller: num1Controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoTextField(
                    controller: num2Controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                    child: Text('더해보기'),
                    onPressed: () {
                      _getCalc(
                          num1Controller.value.text, num2Controller.value.text);
                    }),
                SizedBox(
                  height: 10,
                ),
                Text(_result.toString())
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ));
  }

  Future<void> _getCalc(String value1, String value2) async {
    int result;
    try {
      result = await platform
          .invokeMethod('add', [int.parse(value1), int.parse(value2)]);
    } on PlatformException catch (e) {
      result = -1;
    }
    setState(() {
      _result = result;
    });
  }

}

class NativeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NativeApp();
}

class _NativeApp extends State<NativeApp> {
  static const platform = const MethodChannel('com.flutter.dev/info');
  static const platform3 = const MethodChannel('com.flutter.dev/dialog');
  
  String _deviceInfo = 'Unknown info';
  
  Future<void> _showDialog() async {
    try {
      await platform3.invokeMethod('showDialog');
    } on PlatformException catch(e) {
      
    }
  }

  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      deviceInfo = 'Device info : $result';
    } on PlatformException catch (e) {
      deviceInfo = 'Failed to get Device info: ${e.message}';
    }
    setState((){
      _deviceInfo = deviceInfo;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Native 통신 예제'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children:[
              Text(
                _deviceInfo,
                style: TextStyle(
                    fontSize: 30
                )
              ),
              TextButton(
                onPressed: (){
                  _showDialog();
                },
                child: Text('네이티브 창 열기'),
              )
            ]
           ,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _getDeviceInfo();
        },
        child: Icon(Icons.get_app),
      ),
    );
  }
}