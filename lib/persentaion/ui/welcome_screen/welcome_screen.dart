import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/utlis/app_model.dart';

import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/texts.dart';
import 'componts/rounded_clipper.dart';
import 'componts/ttitle_app.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ClipPath(
              clipper: RoundedClipper(heightScreen(context) / 1.4),
              child: Container(
                color: homeColor,
                height: double.infinity,
                width: double.infinity,
                child: const TitleApp(
                  heightIcon: 70,
                  widthIcon: 100,
                  fontSize: 60,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(children: [
                 Texts(
                    title: Strings.welcomeTo.tr(),
                    textColor: textColor,
                    fontSize: 30,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                sizedHeight(9),
                 Texts(
                    title: Strings.descPlatform.tr(),
                    textColor: textColor2,
                    fontSize: 12,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                sizedHeight(25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ButtonWidget(
                    onPress: () {
                      // print(currentUser.token);
                    Navigator.pushNamed(context, login);
                    },
                    color: buttonsColor,
                    height: 55,
                    child:  Texts(
                        title: Strings.loginOrSignUp.tr(),
                        textColor: Colors.white,
                        fontSize: 14,
                        align: TextAlign.center,
                        weight: FontWeight.bold),
                  ),
                ),
              sizedHeight(10),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 40),
                //   child: ButtonWidget(
                //     isBorder: true,
                //     onPress: () {
                //       Navigator.pushNamed(context, home);
                //     },
                //     color: Colors.white,
                //     height: 55,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //         ),
                //         const Texts(
                //             title: Strings.gust,
                //             textColor: Colors.grey,
                //             fontSize: 14,
                //             align: TextAlign.center,
                //             weight: FontWeight.bold),
                //         Container(
                //             padding: const EdgeInsets.symmetric(horizontal: 20),
                //             child: const Icon(
                //               Icons.arrow_forward,
                //               color: Colors.grey,
                //             ))
                //       ],
                //     ),
                //   ),
                // )
              ]))
        ],
      ),
    );
  }
}
