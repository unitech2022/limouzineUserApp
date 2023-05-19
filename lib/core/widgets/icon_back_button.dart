import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/functions.dart';

class IconBackButton extends StatelessWidget {
  const IconBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white));
  }
}