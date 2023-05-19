import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/persentaion/controller/app_cubit/cubit/app_cubit.dart';

import '../../../core/helpers/helper_functions.dart';

import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/texts.dart';

class ChoseLangScreen extends StatefulWidget {
  const ChoseLangScreen({super.key});

  @override
  State<ChoseLangScreen> createState() => _ChoseLangScreenState();
}

class _ChoseLangScreenState extends State<ChoseLangScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: homeColor,
          body: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: SvgPicture.asset(
                          "assets/icons/login.svg",
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Texts(
                          title: Strings.onTheWay,
                          textColor: Colors.white,
                          fontSize: 28,
                          family: "alex_bold",
                          align: TextAlign.center,
                          weight: FontWeight.bold)
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Texts(
                          title: Strings.selectLang,
                          textColor: textColor,
                          fontSize: 20,
                          family: "alex_bold",
                          align: TextAlign.center,
                          weight: FontWeight.bold),
                      sizedHeight(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: ButtonWidget(
                          isBorder: true,
                          onPress: () {
                            context.setLocale(Locale('ar'));
                            
                            AppCubit.get(context).changeLang("ar", context);
                          },
                          color: Colors.white,
                          height: 55,
                          child: const Texts(
                              title: Strings.arabic,
                              textColor: homeColor,
                              fontSize: 14,
                              align: TextAlign.center,
                              weight: FontWeight.bold),
                        ),
                      ),
                      sizedHeight(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: ButtonWidget(
                          isBorder: true,
                          onPress: () {
                            context.setLocale(Locale('en'));
                             AppCubit.get(context).changeLang("en", context);
                          },
                          color: homeColor,
                          height: 55,
                          child: const Texts(
                              title: Strings.english,
                              textColor: Colors.white,
                              fontSize: 14,
                              align: TextAlign.center,
                              weight: FontWeight.bold),
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
