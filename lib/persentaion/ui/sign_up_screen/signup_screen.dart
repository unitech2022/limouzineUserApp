import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxi/core/utlis/api_constatns.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/domin/entities/user.dart';
import 'package:taxi/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/circle_image_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../core/widgets/texts.dart';
import '../welcome_screen/componts/rounded_clipper.dart';
import '../welcome_screen/componts/ttitle_app.dart';
import 'dart:ui' as ui;

class SignUpScreen extends StatefulWidget {
  final String phone;

  SignUpScreen(this.phone);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _controllerUserName = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerEmail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhone.text = widget.phone.split("+966")[1];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerPhone.dispose();
    _controllerUserName.dispose();
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                Texts(
                    title: Strings.signUp.tr(),
                    textColor: textColor,
                    fontSize: 35,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                Texts(
                    title: Strings.dsecSignUp.tr(),
                    textColor: textColor2,
                    fontSize: 14,
                    align: TextAlign.center,
                    weight: FontWeight.bold),
                sizedHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(children: [
                        state.imageStet == RequestState.loading
                            ? LoadingWidget(height: 120, color: buttonsColor)
                            : CircleImageWidget(
                                height: 120,
                                width: 120,
                                image: ApiConstants.imageUrl(state.image),
                              ),
                        Positioned(
                            left: 0,
                            top: 2,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: const BoxDecoration(
                                  color: buttonsColor, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            )),
                        Positioned(
                            bottom: 0,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                AuthCubit.get(context).uploadImage();
                              },
                              child:
                                  SvgPicture.asset("assets/icons/upload.svg"),
                            ))
                      ]),
                    ),
                  ],
                ),
                sizedHeight(40),
                TextFieldWidget(
                  hint: Strings.hintName.tr(),
                  suffixIcon: const SizedBox(),
                  prefixIcon: Icons.person,
                  input: TextInputType.text,
                  controller: _controllerUserName,
                ),
                sizedHeight(21),
                TextFieldWidget(
                  hint: Strings.hintEmail.tr(),
                  suffixIcon: SizedBox(),
                  prefixIcon: Icons.email,
                  input: TextInputType.emailAddress,
                  controller: _controllerEmail,
                ),
                sizedHeight(21),
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
             , sizedHeight(21),
                state.signUpStet == RequestState.loading
                    ? LoadingWidget(
                        height: 55,
                        color: buttonsColor,
                      )
                    : ButtonWidget(
                        height: 55,
                        color: buttonsColor,
                        onPress: () {
                          if (isValidate()) {
                            User user = User(
                                token: "",
                                id: "",
                                email: _controllerEmail.text,
                                fullName: _controllerUserName.text,
                                userName:
                                    Strings.codeNumber + _controllerPhone.text,
                                profileImage: state.image,
                                role: "user",
                                deviceToken: "deviceToken", points: 0.0);

                            AuthCubit.get(context)
                                .signUpUser(user: user, context: context);
                          }
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

  bool isValidate() {
    if (_controllerUserName.text.isEmpty) {
        showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Color.fromARGB(255, 211, 161, 11),
            message: Strings.pleasEnterName.tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white)));
    
      return false;
    } else if (_controllerEmail.text.isEmpty) {
       showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Color.fromARGB(255, 211, 161, 11),
            message: Strings.pleasEnterEmail.tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white)));
    
      return false;
    } else if (_controllerPhone.text.isEmpty ||
        _controllerPhone.text.length < 8) {

           showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Color.fromARGB(255, 211, 161, 11),
            message:  Strings.pleasEnterPhone.tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white)));
     
      return false;
    } else {
      return true;
    }
  }
}
