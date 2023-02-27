import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Texts extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color textColor;
  final FontWeight weight;
  final TextAlign align;
  final String family;

const  Texts(
      {super.key,
      required this.title,
      required this.textColor,
      required this.fontSize,
      required this.weight,
      required this.align,this.family=""});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: weight,
          fontFamily: family,
          height: 1.2),
    );
  }
}
