
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/circle_image_widget.dart';
import '../../../../core/widgets/texts.dart';

class AppBarHome extends StatelessWidget {
  final void Function() onTap;
  const AppBarHome({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
    
      height: 55,
      child: Row(children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 51,
                  width: 51,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white)),
                  child: const CircleImageWidget(
                      height: 50, width: 50, image: "assets/images/img.png")),
                      sizedWidth(10),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Texts(
                      title: Strings.hello.tr(),
                      textColor: Color(0xffFFFFFF),
                      fontSize: 13,
                      weight: FontWeight.normal,
                      align: TextAlign.right),
                  Texts(
                      title: "خالد بن علي",
                      textColor: textColor,
                      fontSize: 18,
                      weight: FontWeight.normal,
                      align: TextAlign.right)
                ],
              ))
            ],
          ),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    color: textColor, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.menu,
                    color: homeColor,
                  ),
                ),
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
