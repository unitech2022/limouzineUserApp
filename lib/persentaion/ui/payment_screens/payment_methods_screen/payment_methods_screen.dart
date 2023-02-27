import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';
import '../../home_screen/components/app_bar_home.dart';
import '../../home_screen/components/drawer_widget.dart';

class PaymentMethodsScreen extends StatelessWidget {
final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      endDrawer: DrawerWidget(scaffoldKey: _scaffoldKey),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          color: homeColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24,top: 30),
            
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
        child: Column(
      children: [
        Row(
          children: [
            Texts(
                title: Strings.savedPaymentMethod,
                textColor: homeColor,
                fontSize: 31,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ],
        ),
        sizedHeight(50),
         Expanded(
           child: GridView.builder(
                  itemCount: 4,
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
             ),
      
      ],
        ),
      ),
    );
  
  }
}