import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:taxi/core/utlis/api_constatns.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/core/widgets/circle_image_widget.dart';
import 'package:taxi/core/widgets/text_form_field.dart';
import 'package:taxi/core/widgets/texts.dart';
import 'package:taxi/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:taxi/persentaion/ui/home_screen/components/app_bar_home.dart';
import 'package:taxi/persentaion/ui/home_screen/components/drawer_widget.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';

import '../../../core/utlis/strings.dart';
import '../../../core/widgets/button_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controllerName = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerPhone = TextEditingController();

  @override
  void initState() {
    super.initState();

    AuthCubit.get(context).getUserDetails().then((value) {
      if (AuthCubit.get(context).userDetail != null) {
        _controllerName.text = AuthCubit.get(context).userDetail!.fullName!;
         _controllerEmail.text = AuthCubit.get(context).userDetail!.email!;
          _controllerPhone.text = AuthCubit.get(context).userDetail!.userName!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(
            scaffoldKey: _scaffoldKey,
          ),
          body: state.getUserState == RequestState.loading
              ? Center(
                  child: LoadingWidget(height: 40, color: homeColor),
                )
              : Column(children: [
                  SizedBox(
                    height: heightScreen(context) / 2.5,
                    child: Stack(
                      children: [
                        Container(
                          height: heightScreen(context) / 2.5 - 60,
                          margin: const EdgeInsets.only(bottom: 0),
                          decoration: const BoxDecoration(
                              color: homeColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(250),
                                bottomRight: Radius.circular(250),
                              )),
                        ),
                        Positioned(
                          top: 53,
                          left: 24,
                          right: 24,
                          child: AppBarHome(
                            onTap: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  AuthCubit.get(context).uploadImage();
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: textColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: textColor, width: 4)),
                                  child: state.imageStet == RequestState.loading
                                      ? LoadingWidget(
                                          height: 120, color: Colors.white)
                                      : CircleImageWidget(
                                          height: 120,
                                          width: 120,
                                          image: state.image == ""
                                              ? ApiConstants.imageUrl(state.getUserDetails!=null?state
                                                  .getUserDetails!
                                                  .profileImage!:"")
                                              : ApiConstants.imageUrl(
                                                  state.image)),
                                ),
                              ),
                              // Positioned(
                              //     left: 0,
                              //     top: 2,
                              //     child: Container(
                              //       padding: const EdgeInsets.all(1),
                              //       decoration: const BoxDecoration(
                              //           color: buttonsColor,
                              //           shape: BoxShape.circle),
                              //       child: const Icon(
                              //         Icons.close,
                              //         color: homeColor,
                              //         size: 23,
                              //       ),
                              //     )),

                              state.imageStet == RequestState.loading
                                  ? SizedBox()
                                  : Positioned(
                                      bottom: 0,
                                      right: 2,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                            "assets/icons/upload.svg"),
                                      ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              sizedHeight(40),
                              TextFormFieldWidget(
                                  onTap: () {},
                                  fieldName: Strings.name,
                                  myController: _controllerName,
                                  myIcon: Icons.edit,
                                  inputType: TextInputType.text,
                                  prefixIconColor: Colors.grey),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormFieldWidget(
                                  onTap: () {},
                                  fieldName: Strings.email,
                                  inputType: TextInputType.emailAddress,
                                  myController: _controllerEmail,
                                  myIcon: Icons.edit,
                                  prefixIconColor: Colors.grey),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormFieldWidget(
                                  onTap: () {},
                                  fieldName: Strings.number,
                                  enabel: false,
                                  inputType: TextInputType.number,
                                  myController: _controllerPhone,
                                  myIcon: Icons.edit,
                                  prefixIconColor: Colors.grey),
                              const SizedBox(
                                height: 15,
                              ),
                              // TextFormFieldWidget(
                              //     onTap: () {},
                              //     fieldName: Strings.birthday,
                              //     inputType: TextInputType.number,
                              //     myController: _controllerPhone,
                              //     myIcon: Icons.keyboard_arrow_down_sharp,
                              //     prefixIconColor: Colors.grey),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // TextFormFieldWidget(
                              //     onTap: () {},
                              //     fieldName: Strings.gender,
                              //     inputType: TextInputType.number,
                              //     myController: _controllerPhone,
                              //     myIcon: Icons.keyboard_arrow_down_sharp,
                              //     prefixIconColor: Colors.grey),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // AddIconButton(onPress: () {}),
                              // TextFormFieldWidget(
                              //     onTap: () {},
                              //     fieldName: Strings.defultAddress,
                              //     inputType: TextInputType.number,
                              //     myController: _controllerPhone,
                              //     myIcon: Icons.keyboard_arrow_down_sharp,
                              //     prefixIconColor: Colors.grey),
                              // const SizedBox(
                              //   height: 18,
                              // ),

                              // ButtonSavedData(
                              //   onTap: () {},
                              //   title: Strings.savedAddresses,
                              // ),
                              // const SizedBox(
                              //   height: 15,
                              // ),
                              // AddIconButton(onPress: () {}),
                              // TextFormFieldWidget(
                              //     onTap: () {},
                              //     fieldName: Strings.defultPaymentMethod,
                              //     inputType: TextInputType.number,
                              //     myController: _controllerPhone,
                              //     myIcon: Icons.keyboard_arrow_down_sharp,
                              //     prefixIconColor: Colors.grey),
                              // const SizedBox(
                              //   height: 18,
                              // ),
                              // ButtonSavedData(
                              //   onTap: () {},
                              //   title: Strings.savedPaymentMethod,
                              // ),

                              const SizedBox(
                                height: 51,
                              ),
                              state.updateUserState == RequestState.loading
                                  ? LoadingWidget(
                                      height: 55, color: buttonsColor)
                                  : ButtonWidget(
                                      height: 55,
                                      color: buttonsColor,
                                      onPress: () {
                                        AuthCubit.get(context).updateUser(
                                            fullName: _controllerName.text,
                                            email: _controllerEmail.text,
                                            image: state.image == ""
                                                ? state.getUserDetails!
                                                    .profileImage!
                                                : state.image);
                                      },
                                      child: const Texts(
                                          title: Strings.save,
                                          textColor: Colors.white,
                                          fontSize: 14,
                                          weight: FontWeight.normal,
                                          align: TextAlign.center)),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
        );
      },
    );
  }
}

class ButtonSavedData extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const ButtonSavedData({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/location_icon.svg",
            color: textColor,
          ),
          const SizedBox(
            width: 17,
          ),
          Texts(
              title: title,
              textColor: textColor,
              fontSize: 15,
              weight: FontWeight.normal,
              align: TextAlign.start)
        ],
      ),
    );
  }
}

class AddIconButton extends StatelessWidget {
  final void Function() onPress;
  const AddIconButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: onPress,
              icon: const Icon(
                Icons.add,
                color: textColor3,
              )),
        ],
      ),
    );
  }
}
