import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:taxi/core/utlis/strings.dart';
import 'package:taxi/core/widgets/button_widget.dart';
import 'package:taxi/core/widgets/circle_icon_button.dart';
import 'package:taxi/core/widgets/container.divider.dart';

import '../../../core/helpers/functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';
import 'components/select_address_dialog_widget.dart';

class PackagesScreen extends StatefulWidget {
  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
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
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 225,
              child: Stack(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 200,
                    child: Image.asset(
                      "assets/images/plan.png",
                      height: 205,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      _alertDialogWidget(context);
                    },
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.black),
                      child: Center(
                        child: Texts(
                            title: Strings.subscribeNow,
                            textColor: Colors.white,
                            fontSize: 12,
                            weight: FontWeight.normal,
                            align: TextAlign.start),
                      ),
                    ),
                  ),
                )
              ]),
            );
          }),
    );
  }

  void _alertDialogWidget(context) {
    showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    pop(context);
                  },
                  color: buttonsColor,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    size: 24,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                ),
                sizedHeight(15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  child: Column(children: [
                    sizedHeight(19),
                    Texts(
                        title: Strings.selectDestinations,
                        textColor: Color(0xff464646),
                        fontSize: 30,
                        weight: FontWeight.normal,
                        align: TextAlign.center),
                    sizedHeight(30),

                    // number students
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/studant.svg"),
                        sizedWidth(13),
                        Texts(
                            title: Strings.numberOfStudents,
                            textColor: Color(0xffA5A5A5),
                            fontSize: 12,
                            weight: FontWeight.normal,
                            align: TextAlign.center),
                        // sizedWidth(40),
                        MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            )),

                        Texts(
                            title: "3",
                            textColor: Colors.black,
                            fontSize: 16,
                            weight: FontWeight.normal,
                            align: TextAlign.center),

                        MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Icon(
                              Icons.remove,
                              color: Colors.black,
                            )),
                      ],
                    ),

                    sizedHeight(30),
                    SelectAddressDialogWidget(
                      title: Strings.starting,
                      nameAddress: "منزلي الحالي",
                      address: "3482+V2, Al Mendassah 44289, Saudi Arabia",
                      onPress: () {
                        _getAddressesBottomSheet();
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SelectAddressDialogWidget(
                      title: Strings.end,
                      nameAddress: "مدرسة ابو ايوب الانصاري ",
                      address: "3482+V2, Al Mendassah 44289, Saudi Arabia",
                      onPress: () {},
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    ButtonWidget(
                        child: Texts(
                            title: Strings.continueLogin,
                            textColor: Colors.white,
                            fontSize: 14,
                            weight: FontWeight.normal,
                            align: TextAlign.center),
                        height: 55,
                        color: buttonsColor,
                        onPress: () {
                          pop(context);
                        }),
                    SizedBox(
                      height: 40,
                    ),
                  ]),
                )
              ],
            ),
          );
        });
  }

  void _getAddressesBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24),
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
              sizedHeight(41),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Texts(
                      title: Strings.selectAddress,
                      textColor: Color(0xff464646),
                      fontSize: 18,
                      weight: FontWeight.normal,
                      align: TextAlign.center),
                  CircleIconButton(
                      backgroundColor: Colors.black,
                      onPress: (() {
                        pop(context);
                        Navigator.pushNamed(context, addAddress);
                      }),
                      iconColor: Colors.white,
                      height: 29,
                      icon: Icons.add)
                ],
              ),
              sizedHeight(14),
              // listOf Address
              //
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 75,
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(color: Color(0xffF7F7F7)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/school2.svg",
                              color: Colors.black,
                            ),
                            sizedWidth(15),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts(
                                    title: "مدرسة أبو بكر الصديق",
                                    textColor: Color(0xffA5A5A5),
                                    fontSize: 12,
                                    weight: FontWeight.normal,
                                    align: TextAlign.start),
                                Texts(
                                    title:
                                        "Al Wurud، Engineer Al Anjari Street, Riyadh Saudi Arabia",
                                    textColor: Colors.black,
                                    fontSize: 10,
                                    weight: FontWeight.normal,
                                    align: TextAlign.start),
                              ],
                            )),
                            sizedWidth(20),
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
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
