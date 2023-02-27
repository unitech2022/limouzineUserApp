import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPress;
  final double height;
  final Color color;
  final Widget child;
  final bool isElevation;
  final bool isBorder;

  const ButtonWidget(
      {super.key,
      required this.child,
      required this.height,
      required this.color,
      required this.onPress,
      this.isElevation=true,
      this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation:isElevation? 8 :0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
              color: isBorder ? Colors.transparent : buttonsColor, width: .5)),
      height: height,
      minWidth: double.infinity,
      color: color,
      onPressed: onPress,
      child: child,
    );
  }
}
