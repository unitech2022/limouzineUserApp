import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:taxi/persentaion/ui/booking_screen/booking_screen.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/api_constatns.dart';
import '../../../../core/utlis/app_model.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';
import 'item_menu.dart';

class DrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DrawerWidget({super.key, required this.scaffoldKey});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 38),
      width: widthScreen(context) - 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight:
              AppModel.lang == "ar" ? Radius.circular(0) : Radius.circular(80),
          bottomRight:
              AppModel.lang == "ar" ? Radius.circular(0) : Radius.circular(80),
          topLeft:
              AppModel.lang == "en" ? Radius.circular(0) : Radius.circular(80),
          bottomLeft:
              AppModel.lang == "en" ? Radius.circular(0) : Radius.circular(80),
        ),
        color: Color(0xff0B1B2F),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                widget.scaffoldKey.currentState!.closeDrawer();
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(42, 255, 255, 255)),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        sizedHeight(25),
        Row(
          children: [
            Texts(
                title: Strings.menu.tr(),
                textColor: Colors.white,
                fontSize: 35,
                weight: FontWeight.normal,
                align: TextAlign.right),
          ],
        ),
        Row(
          children: [
            Texts(
                title: Strings.main.tr(),
                textColor: textColor,
                fontSize: 35,
                weight: FontWeight.normal,
                align: TextAlign.right),
          ],
        ),
        sizedHeight(35),
        ItemMenu(
          text: Strings.main.tr(),
          icon: "assets/icons/home_menu.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, home);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.account.tr(),
          icon: "assets/icons/acount.svg",
          child: const Texts(
              title: "",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            pop(context);
            Navigator.pushNamed(context, account);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: "حجوزاتى".tr(),
          icon: "assets/icons/my_plan.svg",
          child: const Texts(
              title: "",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            pop(context);
            pushPage(context: context, page: BookingScreen());
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.lang.tr(),
          icon: "assets/icons/translate.svg",
          child: Texts(
              title: AppModel.lang == "ar" ? "العربية" : "English",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            showMyDialog(
                context: context,
                title:
                    AppModel.lang == "ar" ? "تغيير اللغة" : "Change Language ?",
                body: AppModel.lang == "ar"
                    ? "هل تريد تغيير لغة التطبيق  ؟"
                    : "Do you want to change the language of the application?",
                founction: () async {
                  if (AppModel.lang == "ar") {
                    AppModel.lang = "en";
                    context.setLocale(Locale('en'));
                    await saveData(ApiConstants.langKey, 'en');
                    pop(context);
                    Navigator.pushNamed(context, splash);
                  } else {
                    AppModel.lang = "ar";
                    context.setLocale(Locale('ar'));
                    await saveData(ApiConstants.langKey, 'ar');
                    pop(context);
                    Navigator.pushNamed(context, splash);
                  }
                });
          },
        ),

        sizedHeight(25),

        ItemMenu(
          text: Strings.history.tr(),
          icon: "assets/icons/history.svg",
          child: const Texts(
              title: "",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            pop(context);
            Navigator.pushNamed(context, history);
          },
        ),
        // sizedHeight(25),
        // ItemMenu(
        //   text: Strings.schoolPlan,
        //   icon: "assets/icons/school_menu.svg",
        //   child: const SizedBox(),
        //   onTap: () {
        //     Navigator.pushNamed(context, packages);
        //   },
        // ),

        sizedHeight(25),
        ItemMenu(
          text: Strings.notys.tr(),
          icon: "assets/icons/notifications.svg",
          child: SizedBox(),
          //  Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15), color: buttonsColor),
          //     child: const Texts(
          //         title: "١٢ جديد",
          //         textColor: Color(0xffA5A5A5),
          //         fontSize: 11,
          //         weight: FontWeight.normal,
          //         align: TextAlign.center)),
          onTap: () {
            pop(context);
            Navigator.pushNamed(context, notifications);
          },
        ),

        sizedHeight(25),
        // ItemMenu(
        //   text: Strings.myPlan.tr(),
        //   icon: "assets/icons/my_plan.svg",
        //   child: const Texts(
        //       title: "",
        //       textColor: Color(0xffA5A5A5),
        //       fontSize: 16,
        //       weight: FontWeight.normal,
        //       align: TextAlign.center),
        //   onTap: () {
        //     Navigator.pushNamed(context, subscription);
        //   },
        // ),
        // sizedHeight(25),
        // ItemMenu(
        //   text: Strings.sittings.tr(),
        //   icon: "assets/icons/sittings.svg",
        //   child: const SizedBox(),
        //   onTap: () {
        //     Navigator.pushNamed(context, settings);
        //   },
        // ),
        // sizedHeight(25),
        ItemMenu(
          text: Strings.support.tr(),
          icon: "assets/icons/help.svg",
          child: SizedBox(),
          //  Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15), color: buttonsColor),
          //     child: const Texts(
          //         title: "١٢ جديد",
          //         textColor: Color(0xffA5A5A5),
          //         fontSize: 11,
          //         weight: FontWeight.normal,
          //         align: TextAlign.center)
          //         ),
          onTap: () {
            showSheet(context, selectCall(context));
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.privacy.tr(),
          icon: "assets/icons/aboute.svg",
          child: const SizedBox(),
          onTap: () {},
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Texts(
                title: "V 1.00",
                textColor: Color(0xffA5A5A5),
                fontSize: 16,
                weight: FontWeight.normal,
                align: TextAlign.center),
            GestureDetector(
              onTap: () {
                signOut(ctx: context);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/logout.svg",
                    width: 24,
                    height: 24,
                  ),
                  sizedWidth(18),
                  Texts(
                      title: Strings.logout.tr(),
                      textColor: buttonsColor,
                      fontSize: 16,
                      weight: FontWeight.normal,
                      align: TextAlign.right),
                ],
              ),
            )
          ],
        ),
        sizedHeight(42)
      ]),
    );
  }

  selectCall(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 24,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.5),
                color: const Color(0xFFDCDCDF),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Texts(
                title: Strings.help,
                textColor: buttonsColor,
                fontSize: 16,
                weight: FontWeight.bold,
                align: TextAlign.center),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pop(context);
                        // HelperFunction.slt.launchWhatsapp(
                        //     number: AppCubit.get(context)
                        //         .homeModel
                        //         .sittings![14]
                        //         .value!,
                        //     context: context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              size: 30,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Texts(
                                title: Strings.whatsApp,
                                textColor: buttonsColor,
                                fontSize: 16,
                                weight: FontWeight.bold,
                                align: TextAlign.center)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        pop(context);
                        // HelperFunction.slt.openDialPad(AppCubit.get(context)
                        //     .homeModel
                        //     .sittings![14]
                        //     .value!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              size: 30,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Texts(
                                title: Strings.call,
                                textColor: buttonsColor,
                                fontSize: 16,
                                weight: FontWeight.bold,
                                align: TextAlign.center)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
