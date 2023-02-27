import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/utlis/strings.dart';
import 'package:taxi/core/widgets/container.divider.dart';
import 'package:taxi/core/widgets/texts.dart';

import '../../../core/routers/routers.dart';
import '../../../core/styles/colors.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/circle_icon_button.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class PaymentScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: DrawerWidget(scaffoldKey: _scaffoldKey),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110.0),
          child: Container(
            height: double.infinity,
            alignment: Alignment.center,
            color: homeColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppBarHome(
                onTap: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
              ),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: 197,
                  child: Image.asset(
                    "assets/images/plan.png",
                    height: 197,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                sizedHeight(11),
                //details subscribe

                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffF7F7F7)),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                            child: Texts(
                                title: Strings.detailsSubscrip,
                                textColor: textColor2,
                                fontSize: 16,
                                weight: FontWeight.normal,
                                align: TextAlign.start)),
                        ContainerDivider(
                            height: 22, width: 1, color: Color(0xffA5A5A5)),
                        sizedWidth(11),
                        InkWell(
                            onTap: () {},
                            child: Icon(Icons.keyboard_arrow_down_rounded,
                                color: Color(0xffA5A5A5)))
                      ],
                    ),
                  ),
                ),
                sizedHeight(13),
                // select visa
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffF7F7F7)),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                            child: Texts(
                                title: Strings.payment,
                                textColor: textColor2,
                                fontSize: 16,
                                weight: FontWeight.normal,
                                align: TextAlign.start)),
                        sizedWidth(11),
                        InkWell(
                            onTap: () {
                              _getAddressesBottomSheet(context);
                            },
                            child:
                                SvgPicture.asset("assets/icons/addresses.svg"))
                      ],
                    ),
                  ),
                ),
                sizedHeight(13),
                // select visa
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 23),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Color.fromARGB(154, 156, 155, 155), width: 1)),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                            child: Texts(
                                title: "1234  1569  8564  2369",
                                textColor: Color(0xff464646),
                                fontSize: 16,
                                weight: FontWeight.normal,
                                align: TextAlign.start)),
                        sizedWidth(11),
                        Image.asset("assets/images/visa.png",width: 38,height: 25,)
                      ],
                    ),
                  ),
                ),

                sizedHeight(13),
                // select visa
                ContainerDetailsVisa(
                  value: "NAWAF BIN ALY",
                ),
                sizedHeight(13),
                // select visa
                ContainerDetailsVisa(
                  value: "10 / 29",
                ),

                sizedHeight(60),
                ButtonWidget(
                    isElevation: false,
                    child: Texts(
                        title: "دفع - ٩٩٠. ر.س",
                        textColor: Colors.white,
                        fontSize: 14,
                        weight: FontWeight.normal,
                        align: TextAlign.start),
                    height: 55,
                    color: buttonsColor,
                    onPress: () {
                      Navigator.pushNamed(context, payment);
                    }),
                sizedHeight(23),
                ButtonWidget(
                    isBorder: false,
                    isElevation: false,
                    child: Texts(
                        title: Strings.back,
                        textColor: Colors.black,
                        fontSize: 14,
                        weight: FontWeight.normal,
                        align: TextAlign.start),
                    height: 55,
                    color: Colors.white,
                    onPress: () {}),
                sizedHeight(30)
              ]),
            )));
  }

  // payment methods
  void _getAddressesBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              sizedHeight(25),
              ContainerDivider(
                height: 3,
                width: 150,
                color: Color(0xff707070),
              ),
              sizedHeight(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Texts(
                      title: Strings.pleaceSelectPayment,
                      textColor: Color(0xff464646),
                      fontSize: 18,
                      weight: FontWeight.normal,
                      align: TextAlign.center),
                  CircleIconButton(
                      backgroundColor: Colors.black,
                      onPress: (() {
                       pop(context);
                       Navigator.pushNamed(context, addPayment);
                      }),
                      iconColor: Colors.white,
                      height: 29,
                      icon: Icons.add)
                ],
              ),
              sizedHeight(14),
              // listOf methods payment
              //
              Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      child: Container(
                        height: 141,
                        width: 175,
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Color(0xffF7F7F7),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                          "assets/icons/delete.svg")),
                                  sizedWidth(20),
                                  InkWell(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                          "assets/icons/update.svg")),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/visa.png",width: 38,height: 25,),
                                ],
                              ),
                              Spacer(),
                              Texts(
                                  title: "كرت الوالدة",
                                  textColor: Color(0xffA5A5A5),
                                  fontSize: 11,
                                  weight: FontWeight.normal,
                                  align: TextAlign.start),
                              sizedHeight(12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Texts(
                                        title: "**** **** **** **** 9588",
                                        textColor: Colors.black,
                                        fontSize: 11,
                                        weight: FontWeight.normal,
                                        align: TextAlign.start),
                                  ),
                                  Texts(
                                      title: "10/26",
                                      textColor: Color(0xffA5A5A5),
                                      fontSize: 11,
                                      weight: FontWeight.normal,
                                      align: TextAlign.start)
                                ],
                              ),
                            ]),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ContainerDetailsVisa extends StatelessWidget {
  final String value;
  ContainerDetailsVisa({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 23),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(color: Color.fromARGB(154, 156, 155, 155), width: 1)),
      child: Center(
        child: Row(
          children: [
            Texts(
                title: value,
                textColor: Color(0xff464646),
                fontSize: 16,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ],
        ),
      ),
    );
  }
}
