import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utlis/strings.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../add_address_screen/add_address_screen.dart';
import '../../home_screen/components/app_bar_home.dart';
import '../../home_screen/components/drawer_widget.dart';

class AddPaymentMethodScreen extends StatelessWidget {
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
      ),body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 31),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Texts(
                      title: Strings.addPaymentMethod,
                      textColor: homeColor,
                      fontSize: 31,
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ],
              ),
              sizedHeight(24),
              // container 
              Container(
                height: 180,
                color: Colors.grey,
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
                hint: Strings.numberOrEmail,controller: _controllerName,
              )
               , sizedHeight(11),
              FieldInputAddress(
                hint: Strings.dateEnd,controller: _controllerName,
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