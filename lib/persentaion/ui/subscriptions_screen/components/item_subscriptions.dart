import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';

class ItemSubscriptions extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
          color: Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(10)),
    
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: double.infinity,
            width: 5,
            decoration: BoxDecoration(
                color: buttonsColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                      "assets/icons/subscrip.svg"),
                  sizedWidth(21),
                  Expanded(
                      child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الباقة البلاتينية-14",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "alex_bold",
                            color: Colors.black),
                      ),
                      sizedHeight(8),
                      Row(
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text(
                                Strings.dateSubscribe,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "alex_rg",
                                    color:
                                        Color(0xffA5A5A5)),
                              )),
                          sizedWidth(24),
                          Text(
                            "06-02-2023",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "alex_rg",
                                color: Colors.black),
                          )
                        ],
                      ),
                   
                      Row(
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text(
                                Strings.dateEnd,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "alex_rg",
                                    color:
                                        Color(0xffA5A5A5)),
                              )),
                          sizedWidth(24),
                          Text(
                            "06-02-2023",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "alex_rg",
                                color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
          )
       
       ,Padding(
         padding: const EdgeInsets.all(14.0),
         child: Text(
                          "ملغية",
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: "alex_bold",
                              color: buttonsColor)),
       ),
                            
        ],
      ),
    );
  }
}
