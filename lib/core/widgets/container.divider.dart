
import 'package:flutter/cupertino.dart';

class ContainerDivider extends StatelessWidget {
  final double height, width;
  final Color color;

  const ContainerDivider(
      {super.key, required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color:color),
    );
  }
}
