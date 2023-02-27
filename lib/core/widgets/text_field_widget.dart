import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;

  final TextEditingController controller;
  final Widget suffixIcon;
  final TextInputType input;

  const TextFieldWidget(
      {super.key,
      required this.hint,
      required this.prefixIcon,
      required this.controller,
      required this.suffixIcon,
      required this.input});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 3,
                color: Color.fromARGB(13, 0, 0, 0),
              ),
            ]),
        height: 55,
        child: Center(
          child: TextField(
            controller: controller,
            cursorColor: Colors.grey,
            keyboardType: input,
            decoration: InputDecoration(
                hintText: hint,
                helperStyle:
                    const TextStyle(fontSize: 14, color: Color(0xff464646)),
                border: InputBorder.none,
                suffixIcon: suffixIcon,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                prefixIcon: Icon(
                  prefixIcon,
                  color: Color(0xffDBDBDB),
                )),
          ),
        ));
  }
}
