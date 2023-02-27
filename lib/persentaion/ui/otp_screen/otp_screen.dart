import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/routers/routers.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/texts.dart';
import '../welcome_screen/componts/rounded_clipper.dart';
import '../welcome_screen/componts/ttitle_app.dart';
import 'dart:ui' as ui;

class OtpScreen extends StatefulWidget {
  final String phone;


  OtpScreen({required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String code = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(children: [
            SizedBox(
              height: heightScreen(context) / 3.1,
              child: ClipPath(
                clipper: RoundedClipper(heightScreen(context) / 2.5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  height: double.infinity,
                  color: homeColor,
                  child: const TitleApp(
                    widthIcon: 60,
                    fontSize: 38,
                    heightIcon: 38,
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Texts(
                        title: Strings.codeOtp.tr(),
                        textColor: textColor,
                        fontSize: 35,
                        align: TextAlign.center,
                        weight: FontWeight.bold),
                    Texts(
                        title: Strings.enterCode.tr(),
                        textColor: textColor2,
                        fontSize: 14,
                        align: TextAlign.center,
                        weight: FontWeight.bold),
                    sizedHeight(100),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: textColor2,
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                        ),
                        length: 5,
                        obscureText: false,
                        obscuringCharacter: '*',
                        textStyle: const TextStyle(
                          color: textColor2,
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                        ),
                        blinkWhenObscuring: true,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 3,
                            spreadRadius: 3,
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                        ],
                        animationType: AnimationType.fade,
                        validator: (v) {
                          // if (v.toString().length < 3) {
                          //   return "";
                          // } else {
                          //   return null;
                          // }
                        },
                        pinTheme: PinTheme(
                          fieldOuterPadding: const EdgeInsets.only(left: 2),
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(4),
                          fieldHeight: 78,
                          fieldWidth: 55,
                          borderWidth: 0,
                          inactiveColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: const Color(0xFFE2E2E2),
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor: Colors.white,
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          code = v;
                        },
                        onChanged: (value) {},
                        beforeTextPaste: (text) {
                          return true;
                        },
                      ),
                    ),
                    sizedHeight(21),
                    const Texts(
                        title: "00:59",
                        textColor: Color(0xffA5A5A5),
                        fontSize: 22,
                        weight: FontWeight.normal,
                        align: TextAlign.center),
                    sizedHeight(18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/resent.svg"),
                        sizedWidth(20),
                        Expanded(
                          child: Texts(
                              title: Strings.reSend.tr(),
                              textColor: Color(0xffA5A5A5),
                              fontSize: 14,
                              weight: FontWeight.normal,
                              align: TextAlign.center),
                        ),
                      ],
                    ),
                    sizedHeight(100),
                state.loginStet==RequestState.loading?LoadingWidget(height: 55, color: buttonsColor)   : ButtonWidget(
                        height: 55,
                        color: buttonsColor,
                        onPress: () {
                          AuthCubit.get(context).loginUser(userName: widget.phone,context: context);
                        },
                        child: Texts(
                            title: Strings.continueLogin.tr(),
                            textColor: Colors.white,
                            fontSize: 14,
                            weight: FontWeight.normal,
                            align: TextAlign.center)),
                  ],
                ))
          ]),
        );
      },
    );
  }
}
