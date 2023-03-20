import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:taxi/persentaion/ui/splash_screen/splash_screen.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/api_constatns.dart';
import '../../../../core/utlis/app_model.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';

import '../../../controller/app_cubit/cubit/app_cubit.dart';
import 'item_menu.dart';

class DrawerWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DrawerWidget({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 38),
      width: widthScreen(context) - 70,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: AppModel.lang == "ar" ? Radius.circular(0) : Radius.circular(80),
          bottomRight: AppModel.lang == "ar" ? Radius.circular(0) : Radius.circular(80),
          topLeft: AppModel.lang == "en" ? Radius.circular(0) : Radius.circular(80),
          bottomLeft: AppModel.lang == "en" ? Radius.circular(0) : Radius.circular(80),
        ),
        color: Color(0xff0B1B2F),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.closeDrawer();
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
          children:  [
            Texts(
                title: Strings.menu.tr(),
                textColor: Colors.white,
                fontSize: 35,
                weight: FontWeight.normal,
                align: TextAlign.right),
          ],
        ),
        Row(
          children:  [
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
              title: "٩٥٠ ر.س",
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
          text: Strings.lang.tr(),
          icon: "assets/icons/translate.svg",
          child:  Texts(
              title:AppModel.lang == "ar"? "العربية":"English",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            showMyDialog(
                context: context,
                title: "",
                body: AppModel.lang == "ar"
                    ? "تغيير الى اللغة الانجليزية "
                    : "Translate to Arabic",
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
          text: Strings.notys,
          icon: "assets/icons/notifications.svg",
          child:SizedBox(),
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
        ItemMenu(
          text: Strings.myPlan.tr(),
          icon: "assets/icons/my_plan.svg",
          child: const Texts(
              title: "",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            Navigator.pushNamed(context, subscription);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.sittings.tr(),
          icon: "assets/icons/sittings.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, settings);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.support.tr(),
          icon: "assets/icons/help.svg",
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: buttonsColor),
              child: const Texts(
                  title: "١٢ جديد",
                  textColor: Color(0xffA5A5A5),
                  fontSize: 11,
                  weight: FontWeight.normal,
                  align: TextAlign.center)),
          onTap: () {},
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
            Row(
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
            )
          ],
        ),
        sizedHeight(42)
      ]),
    );
  }
}
