import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/helper_functions.dart';

class IconButtonBack extends StatelessWidget {
  const IconButtonBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () => pop(context), icon: const Icon(Icons.arrow_back,color: Colors.white,));
  }
}