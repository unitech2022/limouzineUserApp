
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/routers/routers.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/texts.dart';

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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
        color: Color(0xff0B1B2F),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                scaffoldKey.currentState!.closeEndDrawer();
              },
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(42, 255, 255, 255)),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        sizedHeight(25),
        Row(
          children: const [
            Texts(
                title: Strings.menu,
                textColor: Colors.white,
                fontSize: 35,
                weight: FontWeight.normal,
                align: TextAlign.right),
          ],
        ),
        Row(
          children: const [
            Texts(
                title: Strings.main,
                textColor: textColor,
                fontSize: 35,
                weight: FontWeight.normal,
                align: TextAlign.right),
          ],
        ),
        sizedHeight(35),
        ItemMenu(
          text: Strings.main,
          icon: "assets/icons/home_menu.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, home);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.account,
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
          text: Strings.lang,
          icon: "assets/icons/translate.svg",
          child: const Texts(
              title: "العربية",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {},
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.history,
          icon: "assets/icons/history.svg",
          child: const Texts(
              title: "١٢٠ رحله",
              textColor: Color(0xffA5A5A5),
              fontSize: 16,
              weight: FontWeight.normal,
              align: TextAlign.center),
          onTap: () {
            pop(context);
            Navigator.pushNamed(context, history);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.schoolPlan,
          icon: "assets/icons/school_menu.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, packages);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.myPlan,
          icon: "assets/icons/my_plan.svg",
          child: const Texts(
              title: "13 يوم متبقي",
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
          text: Strings.sittings,
          icon: "assets/icons/sittings.svg",
          child: const SizedBox(),
          onTap: () {
            Navigator.pushNamed(context, settings);
          },
        ),
        sizedHeight(25),
        ItemMenu(
          text: Strings.support,
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
          text: Strings.privacy,
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
                const Texts(
                    title: Strings.logout,
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
