import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/utlis/data.dart';
import '../../../../../../core/widgets/texts.dart';


class ItemTripType extends StatelessWidget {
  final TypeTrip typeTrip;
  final int currentIndex;

  const ItemTripType({super.key, required this.typeTrip,required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),

      height: 60,
      width: widthScreen(context)/2 -25,
      
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 3,
                color: Color.fromARGB(13, 0, 0, 0),
              ),
            ],
          color: currentIndex==typeTrip.id?buttonsColor:Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        SvgPicture.asset(typeTrip.icon,color: currentIndex==typeTrip.id?Colors.white:homeColor,),
        sizedWidth(12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texts(
                title: typeTrip.title.tr(),
                textColor: currentIndex==typeTrip.id?Colors.white:textColor,
                fontSize: 14,
                weight: FontWeight.normal,
                align: TextAlign.right),
            Texts(
                title: typeTrip.desc.tr(),
                textColor: currentIndex==typeTrip.id?Colors.white:Colors.grey,
                fontSize: 11,
                weight: FontWeight.normal,
                align: TextAlign.right)
          ],
        )
      ]),
    );
  }
}
