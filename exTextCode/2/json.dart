import 'dart:convert';

void main(){
  var jsonString = '''
    [
      {"name": "철수"},
      {"name": "영희"}
    ]
  ''';
  var people = jsonDecode(jsonString);
  var earlyPerson = people[0];

  print(people is List);
  print(earlyPerson is Map);
  print("early Pserson name is " + earlyPerson['name']);
}