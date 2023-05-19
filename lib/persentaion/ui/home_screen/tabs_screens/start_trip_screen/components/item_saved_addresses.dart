import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/data/models/address_model.dart';

import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/styles/colors.dart';

import '../../../../../../core/widgets/texts.dart';


class ItemSavedAddresses extends StatelessWidget {
final AddressResponse address;
const ItemSavedAddresses({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
      width: 170,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
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
        SvgPicture.asset("assets/icons/city.svg",width: 20,color: Colors.black,),
        sizedWidth(12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texts(
                  title: address.label!.split(",")[0],
                  textColor: textColor,
                  fontSize: 14,
                  
                  weight: FontWeight.normal,
                  align: TextAlign.right),
              Texts(
                  title: address.createdAt!.split("T")[0],
                  textColor: Colors.grey,
                  fontSize: 11,
                  weight: FontWeight.normal,
                  align: TextAlign.right)
            ],
          ),
        )
      ]),
   
    );
  }
}
