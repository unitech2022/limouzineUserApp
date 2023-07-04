
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/styles/colors.dart';

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
          SizedBox(
       
            child: SizedBox(
              width: 20,height: 25,
              child: SvgPicture.asset(icon,width: 25,height: 25,color: textColor,))),
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
