import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';

class TitleApp extends StatelessWidget {
  final double widthIcon ,heightIcon;
  final double fontSize;
  const TitleApp({super.key, required this.widthIcon,required this.fontSize,required this.heightIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizedHeight(75),
        SvgPicture.asset(
          "assets/icons/login.svg",width: widthIcon,height: heightIcon,
        ),
         Texts(
            title: Strings.onTheWay.tr(),
            textColor: Colors.white,
            fontSize: fontSize,
             align: TextAlign.center,
            weight: FontWeight.bold)
      ],
    );
  }
}
