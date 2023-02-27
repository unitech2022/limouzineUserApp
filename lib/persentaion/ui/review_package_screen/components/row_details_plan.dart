import 'package:flutter/cupertino.dart';

import '../../../../core/widgets/texts.dart';

class RowDetailsPlan extends StatelessWidget {
  final String title, value;
  RowDetailsPlan({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Texts(
                title: title,
                textColor: Color(0xffA5A5A5),
                fontSize: 14,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ),
          Texts(
              title: value,
              textColor: Color(0xff0B1B2F),
              fontSize: 14,
              weight: FontWeight.normal,
              align: TextAlign.start),
        ],
      ),
    );
  }
}
