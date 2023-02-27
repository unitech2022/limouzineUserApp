
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/texts.dart';

class ItemMenu extends StatelessWidget {
  final String icon, text;
  final void Function() onTap;
  final Widget child;
  const ItemMenu(
      {super.key,
      required this.icon,
      required this.text,
      required this.child,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(

        children: [
          SvgPicture.asset(icon),
          sizedWidth(18),
          Texts(
              title: text,
              textColor: Colors.white,
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.right),
          const Spacer(),
          child
        ],
      ),
    );
  }
}
