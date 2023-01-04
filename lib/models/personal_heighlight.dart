import 'package:flutter/material.dart';

class PersonalHighlight {
  final String imagePath;
  final String title;
  final Color color1;
  final Color color2;
  final String detail2;
  final List<PersonalHighlight> subCategories;
  late String detail1;

  PersonalHighlight({required this.title, required this.imagePath, required this.color1, required this.detail1, required this.detail2, required this.subCategories, required this.color2});
}