import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class AddressScreen extends StatelessWidget {
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
      floatingActionButton:FloatingActionButton(
        backgroundColor: buttonsColor,
        onPressed: () {
      
      } , child: Icon(Icons.add,color: Colors.white,),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 31),
        child: Column(
      children: [
        Row(
          children: [
            Texts(
                title: Strings.savedAddresses,
                textColor: homeColor,
                fontSize: 31,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ],
        ),
        sizedHeight(50),
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
         ),
      
      ],
        ),
      ),
    );
  }
}
