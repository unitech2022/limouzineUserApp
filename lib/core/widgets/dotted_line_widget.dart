import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';

import '../helpers/helper_functions.dart';

class DottedLineWidget extends StatelessWidget {
  const DottedLineWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      dashLength: 10,
      dashGapLength: 10,
      lineLength: widthScreen(context) - 80,
      direction: Axis.horizontal,
      dashColor: Color.fromARGB(165, 152, 152, 152),
    );
  }
}