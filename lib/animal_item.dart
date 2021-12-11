import 'package:flutter/material.dart';

class Animal{
  String? imagePath;
  String? animalName;
  String? kind;
  bool? fliExist = false;

  Animal({
   required this.animalName,
    required this.kind,
    required this.imagePath,
    this.fliExist
  });
}