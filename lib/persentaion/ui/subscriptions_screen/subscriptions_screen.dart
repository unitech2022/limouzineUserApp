import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxi/core/routers/routers.dart';

import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';
import 'components/item_subscriptions.dart';

class SubscriptionsScreen extends StatefulWidget {
  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(scaffoldKey: _scaffoldKey),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          color: homeColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
            child: AppBarHome(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
          child: Column(
            children: [
              Row(
                children: [
                  Texts(
                      title: Strings.subscription,
                      textColor: homeColor,
                      fontSize: 31,
                      weight: FontWeight.normal,
                      align: TextAlign.start),
                ],
              ),
              sizedHeight(50),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TabBar(
                        indicator: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15))),
                        ),
                        indicatorColor: homeColor,
                        labelColor: Color(0xff0B1B2F),
                        unselectedLabelColor: Colors.grey,
                        labelStyle: TextStyle(fontSize: 10),
                        tabs: [
                          Tab(
                            text: Strings.theCurrent,
                            height: 30,
                          ),
                          Tab(
                            text: Strings.thePrevious,
                            height: 30,
                          ),
                        ]),
                  ),
                  Expanded(
                      child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                  ))
                ],
              ),
              sizedHeight(14),
              Expanded(
                  child: TabBarView(
                children: [
                  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, review);
                            },
                            child: ItemSubscriptions());
                      }),
                  Container(
                    color: Colors.white,
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

