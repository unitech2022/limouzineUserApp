import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CircleIconButton extends StatelessWidget {
  final void Function() onPress;
  final Color backgroundColor, iconColor;
  final IconData icon;
  final double height;

  CircleIconButton({
    required this.backgroundColor,
    required this.onPress,
    required this.iconColor,
    required this.height,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      onPressed: onPress,
      color: backgroundColor,
      textColor: Colors.white,
      child: Icon(
        icon,
        size: 24,
      ),
    
      shape: CircleBorder(),
    );
  }
}
