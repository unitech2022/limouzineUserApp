import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/utlis/data.dart';
import '../../../../../../core/widgets/texts.dart';


class ItemSavedAddresses extends StatelessWidget {
final TypeTrip address;
const ItemSavedAddresses({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      width: 170,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
        BoxShadow(
          offset: Offset(0, 0),
          blurRadius: 3,
          spreadRadius: 3,
          color: Color.fromARGB(13, 0, 0, 0),
        ),
      ]),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        SvgPicture.asset(address.icon,width: 20,),
        sizedWidth(12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texts(
                title: address.title,
                textColor: textColor,
                fontSize: 14,
                weight: FontWeight.normal,
                align: TextAlign.right),
            Texts(
                title: address.desc,
                textColor: Colors.grey,
                fontSize: 11,
                weight: FontWeight.normal,
                align: TextAlign.right)
          ],
        )
      ]),
   
    );
  }
}
