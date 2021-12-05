
main(){
  var stream = Stream.fromIterable([1, 2, 3, 4, 5]);

  //가장 앞의 데이터 결과: 1
  stream.first.then((value) => print('first: $value'));

  // //가장 뒤의 데이터 결과 : 5
  // stream.last.then((value) => print('last: $value'));
  //
  // // 현재 스트림이 비어있는
  // stream.isEmpty.then((value) => print('isEmpty : $value'));
  //
  // // 전체 길이: 5
  // stream.length.then((value) => print('length : $value'));
}