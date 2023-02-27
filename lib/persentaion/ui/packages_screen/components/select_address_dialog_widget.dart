import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/texts.dart';

class SelectAddressDialogWidget extends StatelessWidget {
  final String title, nameAddress, address;
  final void Function() onPress;

  SelectAddressDialogWidget(
      {required this.address,
      required this.nameAddress,
      required this.title,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          color: Color(0xffF5F6FA), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/location_icon.svg"),
              sizedWidth(20),
              Texts(
                  title: title,
                  textColor: Color(0xffA5A5A5),
                  fontSize: 12,
                  weight: FontWeight.bold,
                  align: TextAlign.center),
              sizedWidth(30),
              Expanded(
                child: Texts(
                    title: nameAddress,
                    textColor: Colors.black,
                    fontSize: 12,
                    weight: FontWeight.bold,
                    align: TextAlign.start),
              ),
              sizedWidth(8),
              MaterialButton(
                  onPressed: onPress,
                  padding: EdgeInsets.zero,
                  minWidth: 0,
                  height: 0,
                  child:  SvgPicture.asset("assets/icons/addresses.svg")),
               Icon(
                    Icons.my_location,
                    color: Colors.black,size: 15,
                  )
            ],
          ),
          Container(
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xffEFEFF0)),
            child: Center(
              child: Texts(
                  title: address,
                  textColor: Color(0xffA0A0A0),
                  fontSize: 10,
                  weight: FontWeight.normal,
                  align: TextAlign.center),
            ),
          )
        ],
      ),
    );
  }
}
