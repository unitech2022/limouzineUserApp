import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/widgets/texts.dart';

class RowDetailsItemOffer extends StatelessWidget {
  final String icon, value;
  const RowDetailsItemOffer({super.key, required this.icon,required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(
          width: 4,
        ),
         Texts(
            title: value,
            textColor: const Color(0xff5E5E60),
            fontSize: 11,
            weight: FontWeight.normal,
            align: TextAlign.start),
      ],
    );
  }
}
