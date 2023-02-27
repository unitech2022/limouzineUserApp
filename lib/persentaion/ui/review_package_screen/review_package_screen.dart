import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:taxi/core/widgets/button_widget.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/dotted_line_widget.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';
import 'components/row_details_plan.dart';

class ReviewPackageScreen extends StatelessWidget {
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
            child: Column(
          children: [
            Container(
              height: 197,
              child: Image.asset(
                "assets/images/plan.png",
                height: 197,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            sizedHeight(27),
            Row(
              children: [
                Texts(
                    title: Strings.detailsSubscrip,
                    textColor: homeColor,
                    fontSize: 31,
                    weight: FontWeight.normal,
                    align: TextAlign.start),
              ],
            ),
            sizedHeight(20),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 10,
                    decoration: BoxDecoration(
                        color: buttonsColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: buttonsColor)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DottedLineWidget(),
                      RowDetailsPlan(
                        title: Strings.subscriptionPeriod,
                        value: "١٤ يوم",
                      ),
                      DottedLineWidget(),
                      RowDetailsPlan(
                        title: Strings.dateStarting,
                        value: "اليوم : ٠٣-٠٢-٢٠٢٣",
                      ),
                      DottedLineWidget(),
                      RowDetailsPlan(
                        title: Strings.dateEnd,
                        value: "الخميس - ١٦-٠٢-٢٠٢٣",
                      ),
                      DottedLineWidget(),
                      RowDetailsPlan(
                        title: Strings.morningAppointment,
                        value: "٠٧:١٠ ص",
                      ),
                      DottedLineWidget(),
                      RowDetailsPlan(
                        title: Strings.dateBack,
                        value: "٠١:١٣٥ م",
                      ),
                      DottedLineWidget(),
                      RowDetailsPlan(
                        title: Strings.numberOfPeople,
                        value: "5",
                      ),
                      DottedLineWidget(),
                      RowDetailsPlan(
                        title: Strings.starting,
                        value: "٠١:١٣٥ م",
                      ),
                      DottedLineWidget(),

                      // starting
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Texts(
                                  title: Strings.starting,
                                  textColor: Color(0xffA5A5A5),
                                  fontSize: 14,
                                  weight: FontWeight.normal,
                                  align: TextAlign.start),
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Texts(
                                      title: "منزلي الحالي",
                                      textColor: Color(0xff0B1B2F),
                                      fontSize: 14,
                                      weight: FontWeight.normal,
                                      align: TextAlign.start),
                                  sizedHeight(8),
                                  Texts(
                                      title:
                                          "3482+V2, Al Mendassah 44289, Saudi Arabia",
                                      textColor: Color(0xffA0A0A0),
                                      fontSize: 10,
                                      weight: FontWeight.normal,
                                      align: TextAlign.start),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      DottedLineWidget(),
                      // starting
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 120,
                              child: Texts(
                                  title: Strings.theEnd,
                                  textColor: Color(0xffA5A5A5),
                                  fontSize: 14,
                                  weight: FontWeight.normal,
                                  align: TextAlign.start),
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Texts(
                                      title: "مدرسة ابو ايوب الانصاري",
                                      textColor: Color(0xff0B1B2F),
                                      fontSize: 14,
                                      weight: FontWeight.normal,
                                      align: TextAlign.start),
                                  sizedHeight(8),
                                  Texts(
                                      title:
                                          "3482+V2, Al Mendassah 44289, Saudi Arabia",
                                      textColor: Color(0xffA0A0A0),
                                      fontSize: 10,
                                      weight: FontWeight.normal,
                                      align: TextAlign.start),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      DottedLineWidget(),
                    ],
                  )
                ],
              ),
            ),
            sizedHeight(40),
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
          ],
        )),
      ),
    );
  }
}
