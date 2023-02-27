
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/texts.dart';

class CardSettingWidget extends StatelessWidget {
  final String title, subTitle, icon;
  final Widget child;
  final void Function() onTap;
  CardSettingWidget(
      {required this.icon,
      required this.title,
      required this.onTap,
      required this.subTitle,
      required this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        child: Container(
            height: 75,
            padding: EdgeInsets.all(14),
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                SvgPicture.asset(icon),
                sizedWidth(25),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Texts(
                        title: title,
                        textColor: textColor3,
                        fontSize: 16,
                        family: "alex_rg",
                        weight: FontWeight.normal,
                        align: TextAlign.start),
                    Row(
                      children: [
                        Expanded(
                          child: Texts(
                              title: subTitle,
                              textColor: textColor3.withOpacity(.5),
                              fontSize: 12,
                              family: "alex_rg",
                              weight: FontWeight.normal,
                              align: TextAlign.start),
                        ),
                      ],
                    )
                  ],
                )),
                child
              ],
            )),
      ),
    );
  }
}
