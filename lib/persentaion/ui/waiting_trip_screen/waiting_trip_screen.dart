import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/utlis/strings.dart';
import 'package:taxi/core/widgets/texts.dart';

import '../../../core/routers/routers.dart';
import '../../../core/styles/colors.dart';
import '../../../core/widgets/button_widget.dart';

class WaitingTripScreen extends StatelessWidget {
  const WaitingTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Texts(
                title: Strings.searchTodriver.tr(),
                textColor: Color(0xff010F07),
                fontSize: 25,
                weight: FontWeight.bold,
                align: TextAlign.start),
            const SizedBox(
              height: 40,
            ),
            ButtonWidget(
                height: 55,
                color: buttonsColor,
                onPress: () {
                  pushPageRoutName(context, externalTrip);
                },
                child: Texts(
                    title: Strings.myTrip.tr(),
                    textColor: Colors.white,
                    fontSize: 25,
                    weight: FontWeight.bold,
                    align: TextAlign.center))
          ],
        )),
      ),
    );
  }
}
