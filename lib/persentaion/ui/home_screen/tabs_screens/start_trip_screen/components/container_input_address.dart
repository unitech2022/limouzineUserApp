import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/widgets/texts.dart';


class ContainerInputAddress extends StatelessWidget {
  final String title, value;
  final void Function() onTap;
  final Widget addAddressWidget;
  const ContainerInputAddress(
      {super.key,
      required this.title,
      required this.value,
      required this.onTap,
      required this.addAddressWidget});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 9,
              width: 9,
              decoration: const BoxDecoration(
                  color: buttonsColor, shape: BoxShape.circle),
            ),
            sizedWidth(20),
            Texts(
                title: title,
                textColor: const Color(0xff0B1B2F),
                fontSize: 15,
                weight: FontWeight.bold,
                align: TextAlign.center),
            sizedWidth(30),
            Expanded(
              child: Texts(
                  title: value,
                  textColor: Colors.grey,
                  fontSize: 10,
                  weight: FontWeight.bold,
                  align: TextAlign.start),
            ),
            addAddressWidget,
            sizedWidth(17),
           Icon(
                  Icons.my_location,
                  color: textColor,
                )
          ],
        ),
      ),
    );
  }
}
