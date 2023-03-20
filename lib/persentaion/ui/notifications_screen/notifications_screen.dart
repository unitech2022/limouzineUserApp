import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/texts.dart';
import '../../../data/models/notification.dart';
import '../../controller/notifictions_cubit/cubit/notifications_cubit.dart';
import '../home_screen/components/app_bar_home.dart';
import '../home_screen/components/drawer_widget.dart';
import '../login_screen/login_screen.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationsCubit.get(context).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      // appBar: PreferredSize(
      //     preferredSize: Size.fromHeight(50.0),
      //     child: AppBarHome(
      //       title: Strings.notys,
      //       onTap: () {
      //         _scaffoldKey.currentState!.openDrawer();
      //       },
      //       child: Container(
      //         margin: EdgeInsets.all(12),
      //         height: 16,
      //         width: 26,
      //         child: SvgPicture.asset(
      //           "assets/icons/login.svg",
      //           color: Colors.white,
      //           height: 16,
      //           width: 26,
      //         ),
      //       ),
      //     )),
     
     
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          return state.getNotificationsState == RequestState.loading
              ? Center(child: LoadingWidget(height: 55, color: homeColor))
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 11),
                  child: state.notifications.isEmpty
                      ? ListEmptyWidget(
                          title: Strings.notNoty.tr(),
                          textColor: homeColor,
                        )
                      : SingleChildScrollView(
                          child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xffEAEAEA)),
                                  child: Texts(
                                      title: Strings.today,
                                      textColor: Colors.black,
                                      fontSize: 10,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                ),
                              ],
                            ),
                            sizedHeight(11),
                            ListView.builder(
                                itemCount: state.notifications.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  NotificationModel notificationModel =
                                      state.notifications[index];
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 4),
                                    height: 65,
                                    decoration: BoxDecoration(
                                        color: Color(0xffEAEAEA),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/notify.svg",
                                          height: 28,
                                          width: 28,
                                          fit: BoxFit.cover,
                                        ),
                                        sizedWidth(24),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Texts(
                                                title: notificationModel.title!,
                                                textColor: Color(0xffA5A5A5),
                                                fontSize: 12,
                                                weight: FontWeight.bold,
                                                align: TextAlign.start),
                                            Texts(
                                                title: notificationModel.body!,
                                                textColor: Colors.black,
                                                fontSize: 10,
                                                weight: FontWeight.bold,
                                                align: TextAlign.start),
                                          ],
                                        ))
                                      ],
                                    ),
                                  );
                                })
                          ],
                        )),
                );
        },
      ),
    );
  }
}

class ListEmptyWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  ListEmptyWidget({required this.textColor, required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Texts(
            title: title,
            textColor: textColor,
            fontSize: 16,
            weight: FontWeight.bold,
            align: TextAlign.center));
  }
}
