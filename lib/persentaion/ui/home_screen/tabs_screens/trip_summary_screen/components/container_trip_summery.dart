
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/widgets/texts.dart';

class ContainerTripSummery extends StatelessWidget {
  final String title, value;

  const ContainerTripSummery({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/location_icon.svg"),
          sizedWidth(11),
          Texts(
              title: title,
              textColor: textColor3,
              fontSize: 12,
              weight: FontWeight.bold,
              align: TextAlign.center),
          sizedWidth(23),
          Expanded(
            child: Texts(
                title: value,
                textColor: textColor3,
                fontSize: 10,
                weight: FontWeight.normal,
                align: TextAlign.start),
          )
        ],
      ),
    );
  }
}
