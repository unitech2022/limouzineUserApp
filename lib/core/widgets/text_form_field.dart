import 'package:flutter/material.dart';
import 'package:taxi/core/styles/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final void Function() onTap;
  final TextInputType inputType;
  final bool enabel;
  const TextFormFieldWidget(
      {super.key,
      required this.fieldName,
      required this.myController,
      required this.myIcon,
      required this.prefixIconColor,
      required this.onTap,
      this.enabel=true,
      required this.inputType});
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: myController,
        keyboardType: inputType,
        
        style: const TextStyle(color: textColor3),
        cursorColor: Colors.grey,
        enabled: enabel,
        decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.grey),
            labelText: fieldName,
            suffixIcon: InkWell(
                onTap: onTap,
                child: Icon(
                  myIcon,
                  color: const Color(0xffA5A5A5),
                  size: 18,
                )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xffDBDBDB)),
            ),
            labelStyle: const TextStyle(color: Color(0xffDBDBDB))),
      ),
    );
  }
}
