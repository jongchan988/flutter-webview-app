void main(){
  processOne();
  processTwo();
  processThree();
  processFour();
}

void processOne(){
  print('process one action');
}

void processTwo(){
  Future.delayed(Duration(seconds:1),(){
    print('processTwo Future delay 1 seconds');
  });
  print('porcess two action');
}

void processThree() async{
  await Future.delayed(Duration(seconds: 2), (){
    print('processThree await delayed 2 seconds');
  });
  print('process three action');
}

void processFour(){
  print('process four action');
}