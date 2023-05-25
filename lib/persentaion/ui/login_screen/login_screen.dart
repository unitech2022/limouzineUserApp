import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/core/widgets/button_widget.dart';
import 'package:taxi/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../welcome_screen/componts/rounded_clipper.dart';
import '../welcome_screen/componts/ttitle_app.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controllerPhone = TextEditingController();

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
                    widthIcon: 64,
                    fontSize: 38,
                    heightIcon: 38,
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                Texts(
                    title: Strings.loginTitle.tr(),
                    textColor: textColor,
                    fontSize: 35,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                Texts(
                    title: Strings.descLogin.tr(),
                    textColor: textColor2,
                    fontSize: 14,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                sizedHeight(70),
                     Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Container(
                      height: 55,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                  
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const[
                          BoxShadow(
                              color: Color.fromARGB(70, 158, 158, 158), //New
                              blurRadius: 20.0,
                              offset: Offset(1, 1))
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          sizedWidth(8),
                          Image.asset("assets/images/flag.png"),
                          sizedWidth(8),
                          const Texts(
                              title: Strings.codeNumber,
                              textColor: Color(0xff464646),
                              fontSize: 14,
                              weight: FontWeight.bold,
                              align: TextAlign.center),
                          sizedWidth(8),
                          Expanded(
                            child: SizedBox(
                                height: 60,
                                child: Center(
                                  child: TextField(
                                    controller: _controllerPhone,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.grey,
                                    maxLength: 9,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        hintStyle: TextStyle(fontSize: 14),
                                        isDense: true,
                                        hintText: Strings.enterNumber.tr(),
                                        border: InputBorder.none
                                    ),
                                  ),
                                )),
                          ),
                          sizedWidth(8),
                  
                  
                        ],
                      ),
                  
                    ),
                  )
             
                /* TextFieldWidget(
                      hint: Strings.hintEmail,
                      suffixIcon: const SizedBox(),
                      prefixIcon: Icons.email,
                      input: TextInputType.emailAddress,
                      controller: _controller,
                    ),
                    sizedHeight(21),
                    TextFieldWidget(
                      hint: Strings.hintPass,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.remove_red_eye_sharp,
                            color: Color(0xffDBDBDB),
                          )),
                      prefixIcon: Icons.lock_rounded,
                      input: TextInputType.visiblePassword,
                      controller: _controller,
                    ),*/
                ,sizedHeight(21),
                state.checkUserStet == RequestState.loading
                    ? LoadingWidget(
                        height: 55,
                        color: buttonsColor,
                      )
                    : ButtonWidget(
                        height: 55,
                        color: buttonsColor,
                        onPress: () {
                          if (_controllerPhone.text.isEmpty ||
                              _controllerPhone.text.length < 8) {
                            showTopMessage(
                                context: context,
                                customBar: CustomSnackBar.error(
                                    backgroundColor: Colors.red,
                                    message: Strings.pleasEnterPhone.tr(),
                                    textStyle: TextStyle(
                                        fontFamily: "font",
                                        fontSize: 16,
                                        color: Colors.white)));
                          } else {
                            AuthCubit.get(context).checkUser(
                                userName: "+966" + _controllerPhone.text,
                                context: context);
                          }
                        },
                        child: Texts(
                            title: Strings.login.tr(),
                            textColor: Colors.white,
                            fontSize: 14,
                            weight: FontWeight.normal,
                            align: TextAlign.center)),
                sizedHeight(20),
                /*  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Texts(
                            title: Strings.forgetPass,
                            textColor: Color(0xffA5A5A5),
                            fontSize: 15,
                            weight: FontWeight.normal,
                            align: TextAlign.center),
                        Texts(
                            title: Strings.forgetUserName,
                            textColor: Color(0xffA5A5A5),
                            fontSize: 15,
                            weight: FontWeight.normal,
                            align: TextAlign.center)
                      ],
                    ),
                    sizedHeight(41),
                    ButtonWidget(
                      isElevation: false,
                      height: 55,
                      color: Colors.white,
                      onPress: () {
                        Navigator.pushNamed(context, signUp);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20),
                          ),
                          const Texts(
                              title: Strings.signUp,
                              textColor: Colors.grey,
                              fontSize: 14,
                              align: TextAlign.center,
                              weight: FontWeight.bold),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    ),*/
              ],
            ))
          ]),
        );
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final double height;
  final Color color;
  const LoadingWidget({required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
