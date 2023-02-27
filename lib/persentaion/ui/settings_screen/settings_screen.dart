import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/helpers/helper_functions.dart';

import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';
import 'components/card_setting_widget.dart';

class SettingsScreen extends StatelessWidget {
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
            padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
            child: AppBarHome(
              onTap: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 45, bottom: 30),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Texts(
                    title: Strings.settings,
                    textColor: buttonsColor,
                    fontSize: 31,
                    family: "alex_rg",
                    weight: FontWeight.normal,
                    align: TextAlign.start),
              ],
            ),
            sizedHeight(24),
            Row(
              children: [
                SizedBox(
                  width: 280,
                  child: Texts(
                      title: Strings.descSettings,
                      textColor: textColor3,
                      fontSize: 16,
                      family: "alex_rg",
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ),
              ],
            ),
            sizedHeight(18),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/profile.svg",
                title: Strings.personalInformation,
                subTitle: Strings.updatingInfo,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/lock.svg",
                title: Strings.password,
                subTitle: Strings.updatePassword,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/card.svg",
                title: Strings.payment,
                subTitle: Strings.systemPayment,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/decument.svg",
                title: Strings.subscription,
                subTitle: Strings.loginSubscrip,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/decument.svg",
                title: Strings.savedAddresses,
                subTitle: Strings.savedAddresses,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/share2.svg",
                title: Strings.shareFrinds,
                subTitle: Strings.makeInvinet,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
            sizedHeight(37),
            Row(
              children: [
                Texts(
                    title: Strings.notys,
                    textColor: buttonsColor,
                    fontSize: 20,
                    family: "alex_bold",
                    weight: FontWeight.normal,
                    align: TextAlign.start),
              ],
            ),
            sizedHeight(14),

             CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/notify.svg",
                title: Strings.app,
                subTitle: Strings.notyApp,
                child: SizedBox(
                  width: 46,
                  height: 30,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: CupertinoSwitch(
                     
                      activeColor: Color(0xff22A45D) ,
                      thumbColor: Colors.white,
                      trackColor:Color.fromARGB(255, 148, 150, 149) ,
                      onChanged: (value) {
                      
                    },value: true,),
                  ),
                )
                ),
          

             CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/notify.svg",
                title: Strings.messages,
                subTitle: Strings.messagesToNumber,
                child: SizedBox(
                  width: 46,
                  height: 30,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: CupertinoSwitch(
                     
                      activeColor: Color(0xff22A45D) ,
                      thumbColor: Colors.white,
                      trackColor:Color.fromARGB(255, 148, 150, 149) ,
                      onChanged: (value) {
                      
                    },value: false,),
                  ),
                )
                ),

                

             CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/notify.svg",
                title: Strings.adds,
                subTitle: Strings.smsNoty,
                child: SizedBox(
                  width: 46,
                  height: 30,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: CupertinoSwitch(
                     
                      activeColor: Color(0xff22A45D) ,
                      thumbColor: Colors.white,
                      trackColor:Color.fromARGB(255, 148, 150, 149) ,
                      onChanged: (value) {
                      
                    },value: true,),
                  ),
                )
                ),
         
           sizedHeight(37),
            Row(
              children: [
                Texts(
                    title: Strings.others,
                    textColor: buttonsColor,
                    fontSize: 20,
                    family: "alex_bold",
                    weight: FontWeight.normal,
                    align: TextAlign.start),
              ],
            ),
            sizedHeight(14),
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/rating.svg",
                title: Strings.rateApp,
                subTitle: Strings.onApple,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),
          
            CardSettingWidget(
                onTap: () {},
                icon: "assets/icons/document.svg",
                title: Strings.uses,
                subTitle: Strings.praivcy,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor3,
                  size: 14,
                )),

                  sizedHeight(17),

  ButtonWidget(
                height: 55,
                color: buttonsColor,
                onPress: () {
               
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/logout2.svg"),
                    sizedWidth(24)
                   , const Texts(
                        title: Strings.loginOrSignUp,
                        textColor: Colors.white,
                        fontSize: 14,
                        weight: FontWeight.normal,
                        align: TextAlign.center),
                  ],
                )),
          sizedHeight(22), 
           Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/delete2.svg"),
                    sizedWidth(24)
                   , const Texts(
                        title: Strings.deleteAccount,
                        textColor: Colors.red,
                        fontSize: 14,
                        weight: FontWeight.bold,
                        align: TextAlign.center),
                  ],
                ),
          
          ],
        )),
      ),
    );
  }
}
