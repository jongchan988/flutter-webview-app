import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDesignPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CupertinoDesignPage();
}

class _CupertinoDesignPage extends State<CupertinoDesignPage>{
  FixedExtentScrollController? firstController;
  double _value = 1;
  @override
  void initState(){
    super.initState();
    firstController = FixedExtentScrollController(
      initialItem: 0
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          child: Icon(Icons.arrow_back_ios),
          onPressed: (){
          },
        ),
        middle: Text('Cupertino Design'),
        trailing: CupertinoButton(
          child: Icon(Icons.exit_to_app),
          onPressed: (){
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              CupertinoButton(
                child: Text('PICKER'),
                onPressed: (){
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context){
                      return Container(
                        height: 400,
                        child: Column(
                          children: [
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 50,
                                backgroundColor: Colors.white,
                                scrollController: firstController,
                                onSelectedItemChanged: (index){},
                                children: List<Widget>.generate(10, (index){
                                  return Center(
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        (++index).toString(),
                                      ),
                                    ),
                                  );
                                })
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text('취소'),
                            )
                          ],
                        ),
                      );
                    }
                  );
                },
              ),
              CupertinoSlider(
                value: _value,
                onChanged: (index){
                  setState(() {
                    _value = index;
                  });
                },
                max: 100,
                min: 1,
              ),
              Text(_value.toString())
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
    );
  }
}