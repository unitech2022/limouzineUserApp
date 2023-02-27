import 'package:flutter/material.dart';

import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/utlis/strings.dart';
import 'package:taxi/core/widgets/texts.dart';

import '../../../core/styles/colors.dart';
import '../../../core/widgets/button_widget.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';

class AddAddressScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controllerName = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: DrawerWidget(scaffoldKey: _scaffoldKey),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          color: homeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppBarHome(
              onTap: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 31),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Texts(
                      title: Strings.addNewAddress,
                      textColor: homeColor,
                      fontSize: 31,
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ],
              ),
              sizedHeight(24),
              Container(
                height: 180,
                child: Image.asset(
                  "assets/images/map.png",
                  height: 180,
                ),
              ),
              sizedHeight(24),
              FieldInputAddress(
                hint: Strings.name,controller: _controllerName,
              )
              , sizedHeight(11),
              FieldInputAddress(
                hint: Strings.region,controller: _controllerName,
              )
               , sizedHeight(11),
              FieldInputAddress(
                hint: Strings.widget,controller: _controllerName,
              )
               , sizedHeight(11),
              FieldInputAddress(
                hint: Strings.street,controller: _controllerName,
              )
               , sizedHeight(11),
              FieldInputAddress(
                hint: Strings.building,controller: _controllerName,
              )
               , sizedHeight(11),
              FieldInputAddress(
                hint: Strings.role,controller: _controllerName,
              )
               , sizedHeight(11),
              FieldInputAddress(
                hint: Strings.unit,controller: _controllerName,
              )
               , sizedHeight(29),

                 ButtonWidget(
                        child: Texts(
                            title: Strings.save,
                            textColor: Colors.white,
                            fontSize: 14,
                            weight: FontWeight.normal,
                            align: TextAlign.center),
                        height: 55,
                        color: buttonsColor,
                        onPress: () {
                          pop(context);
                        }),

            ],
          ),
        ),
      ),
    );
  }
}

class FieldInputAddress extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  FieldInputAddress({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffDBDBDB))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Texts(
              title: hint,
              textColor: Color(0xffA5A5A5),
              fontSize: 12,
              weight: FontWeight.normal,
              align: TextAlign.start),
          sizedWidth(58),
          Expanded(
              child: TextFormField(
            controller: controller,
            cursorColor: Colors.grey,
            style: TextStyle(color: Colors.black, fontSize: 12),
            decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero),
          ))
        ],
      ),
    );
  }
}
