import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/utlis/strings.dart';
import 'package:taxi/core/widgets/circle_image_widget.dart';
import 'package:taxi/core/widgets/texts.dart';
import 'package:taxi/persentaion/ui/home_screen/components/app_bar_home.dart';
import 'package:taxi/persentaion/ui/home_screen/components/drawer_widget.dart';

import '../../../core/helpers/helper_functions.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 1;

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 27),
        child: Column(children: [
          // tabs
          Container(
            height: 56,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Color(0xffDBDBDB),
                ),
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                TabHistoryWidget(
                  title: Strings.coming,
                  textColor: index == 0 ? Colors.white : Color(0xffA5A5A5),
                  containerColor: index == 0 ? textColor : Colors.transparent,
                  onTap: () {},
                ),
                TabHistoryWidget(
                  title: Strings.done,
                  textColor: index == 1 ? Colors.white : Color(0xffA5A5A5),
                  containerColor: index == 1 ? textColor : Colors.transparent,
                  onTap: () {},
                ),
                TabHistoryWidget(
                  title: Strings.canceled,
                  textColor: index == 2 ? Colors.white : Color(0xffA5A5A5),
                  containerColor: index == 2 ? textColor : Colors.transparent,
                  onTap: () {},
                ),
              ],
            ),
          )

          // list Of history
          ,
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.only(top: 14),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 30),
                    height: 275,
                    child: Stack(
                      children: [
                        // details trip
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 262,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Color(0xffF7F7F7)),
                            child: Column(children: [
                              sizedHeight(24),
                              ContainerDetailsTrip(
                                colorIcon: buttonsColor,
                                time: "????:???? ??",
                                value:
                                    "3482+V2, Al Mendassah 44289, Saudi Arabia",
                                title: Strings.starting,
                              ),
                              ContainerDetailsTrip(
                                colorIcon: textColor,
                                time: "????:???? ??",
                                value: "44299, Saudi Arabia",
                                title: Strings.arrive,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                child: Row(
                                  children: [
                                    Texts(
                                        title: Strings.details,
                                        textColor: textColor3,
                                        fontSize: 12,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xff707070)),
                                        top: BorderSide(
                                            color: Color(0xff707070)))),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Texts(
                                          title: Strings.cost,
                                          textColor: Color(0xffA0A0A0),
                                          fontSize: 12,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                      sizedWidth(23),
                                      Expanded(
                                        child: Texts(
                                            title: "290 ??.??",
                                            textColor: textColor3,
                                            fontSize: 10,
                                            weight: FontWeight.normal,
                                            align: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Color(0xff707070)),
                                )),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Texts(
                                          title: Strings.driver,
                                          textColor: Color(0xffA0A0A0),
                                          fontSize: 12,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                      sizedWidth(23),
                                      CircleImageWidget(
                                          height: 19,
                                          width: 19,
                                          image: "assets/images/person.png"),
                                      sizedWidth(14),
                                      Expanded(
                                        child: Texts(
                                            title: "?????????? ???????? ????????",
                                            textColor: textColor3,
                                            fontSize: 10,
                                            weight: FontWeight.normal,
                                            align: TextAlign.start),
                                      ),
                                      Image.asset(
                                        "assets/images/imag1.png",
                                        width: 44,
                                        height: 23,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration:
                                    BoxDecoration(color: Color(0xffEAEAEA)),
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Center(
                                  child: Row(
                                    children: [
                                      RowItemWidget(
                                      onTap: () {

                                      },
                                      color: Colors.red,
                                      icon:  "assets/icons/download_cell.svg",
                                      text: Strings.downloadInvoice,
                                    ) ,

                                    DividerHorizontal(
                                      height: double.infinity,
                                      width: 1,
                                      color:  Color(0xff707070),
                                    ),
                                    RowItemWidget(
                                      onTap: () {

                                      },
                                      color: Colors.black,
                                      icon:  "assets/icons/repeat.svg",
                                      text: Strings.repetition,
                                    ) ,
                                     DividerHorizontal(
                                      height: double.infinity,
                                      width: 1,
                                      color:  Color(0xff707070),
                                    ),
                                    RowItemWidget(
                                      onTap: () {

                                      },
                                      color: Colors.black,
                                      icon:  "assets/icons/share.svg",
                                      text: Strings.share,
                                    ) ,



                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),

                        // container date
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            alignment: Alignment.center,
                            height: 26,
                            width: 110,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color(0xffDBDBDB)),
                            child: Texts(
                                title: Strings.today,
                                textColor: Colors.black,
                                fontSize: 12,
                                weight: FontWeight.normal,
                                align: TextAlign.center),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}

class DividerHorizontal extends StatelessWidget {
  final double height,width;
  final Color color;
  
  const DividerHorizontal({required this.color,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width: width,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color:color
      ),
    );
  }
}

class RowItemWidget extends StatelessWidget {
  final String icon, text;
  final Color color;
  final void Function() onTap;
  RowItemWidget({required this.color, required this.text, required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
           icon,
            color: color,
          ),
          sizedWidth(9),
          Texts(
              title:text,
              textColor:color,
              fontSize: 10,
              weight: FontWeight.bold,
              align: TextAlign.start),
        ],
      ),
    ));
  }
}

class ContainerDetailsTrip extends StatelessWidget {
  final String title, value, time;
  final Color colorIcon;

  ContainerDetailsTrip({
    required this.title,
    required this.value,
    required this.time,
    required this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 30,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xff707070)))),
      child: Center(
        child: Row(
          children: [
            Container(
              height: 9,
              width: 9,
              decoration:
                  BoxDecoration(color: colorIcon, shape: BoxShape.circle),
            ),
            sizedWidth(11),
            Texts(
                title: title,
                textColor: textColor3,
                fontSize: 12,
                weight: FontWeight.bold,
                align: TextAlign.center),
            sizedWidth(23),
            Expanded(
              child: Texts(
                  title: value,
                  textColor: Color(0xffA0A0A0),
                  fontSize: 10,
                  weight: FontWeight.normal,
                  align: TextAlign.start),
            ),
            Texts(
                title: time,
                textColor: Color(0xffA0A0A0),
                fontSize: 10,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ],
        ),
      ),
    );
  }
}

class TabHistoryWidget extends StatelessWidget {
  final Color textColor;
  final Color containerColor;
  final String title;
  final void Function() onTap;

  TabHistoryWidget(
      {required this.textColor,
      required this.containerColor,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Texts(
                title: title,
                textColor: textColor,
                fontSize: 18,
                weight: FontWeight.normal,
                align: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
