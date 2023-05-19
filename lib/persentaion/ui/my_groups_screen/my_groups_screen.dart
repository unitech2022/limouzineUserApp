import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/data/models/group_location.dart';
import 'package:taxi/persentaion/controller/trip_cubit/trip_cubit.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';
import 'package:taxi/persentaion/ui/notifications_screen/notifications_screen.dart';
import '../../../core/helpers/helper_functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/strings.dart';
import '../../../core/widgets/icon_back_button.dart';
import '../../../core/widgets/texts.dart';
import '../home_screen/components/drawer_widget.dart';
import '../home_screen/tabs_screens/trip_summary_screen/components/container_trip_summery.dart';

class MyGroupsScreen extends StatefulWidget {
  MyGroupsScreen({super.key});

  @override
  State<MyGroupsScreen> createState() => _MyGroupsScreenState();
}

class _MyGroupsScreenState extends State<MyGroupsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    TripCubit.get(context).getGroups(userId: currentUser.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(
        scaffoldKey: _scaffoldKey,
      ),
      appBar: AppBar(
        title: Text(Strings.tripExternal.tr()),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white)),
        ],
        leading: IconBackButton(),
      ),
      body: BlocBuilder<TripCubit, TripState>(
        builder: (context, state) {
          return state.getGroupsState == RequestState.loading
              ? Center(
                  child: LoadingWidget(height: 55, color: homeColor),
                )
              : state.groupsLocation.isEmpty
                  ? ListEmptyWidget(
                      textColor: homeColor, title: Strings.notTrips.tr())
                  : ListView.builder(
                      itemCount: state.groupsLocation.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      itemBuilder: (ctx, index) {
                        GroupLocation groupLocation =
                            state.groupsLocation[index];
                        return Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Texts(
                                        title: Strings.numberTrip.tr(),
                                        textColor: Colors.black,
                                        fontSize: 16,
                                        weight: FontWeight.normal,
                                        align: TextAlign.right),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Texts(
                                        title: groupLocation.id.toString(),
                                        textColor: Colors.black,
                                        fontSize: 16,
                                        weight: FontWeight.normal,
                                        align: TextAlign.right),
                                    Spacer(),
                                    Texts(
                                        title: groupLocation.createdAt
                                            .split("T")[0],
                                        textColor: Colors.black54,
                                        fontSize: 16,
                                        weight: FontWeight.normal,
                                        align: TextAlign.right),
                                  ],
                                ),
                                sizedHeight(20)
                                // starting point
                                ,
                                ContainerTripSummery(
                                  onTap: () {},
                                  title: Strings.starting.tr(),
                                  value: groupLocation.startLocation,
                                ),
                                sizedHeight(6),
                                // end point
                                ContainerTripSummery(
                                  onTap: () {},
                                  title: Strings.arrive.tr(),
                                  value: groupLocation.endLocation,
                                ),
                                sizedHeight(20),
                                Texts(
                                    title: statusTrip[groupLocation.status],
                                    textColor:
                                        statusTripColor[groupLocation.status],
                                    fontSize: 16,
                                    weight: FontWeight.normal,
                                    align: TextAlign.right),
                              ],
                            ));
                      });
        },
      ),
    );
  }
}



List<String> statusTrip = [
  "جارى البحث عن سائق",
  "تم قبول الرحلة",
  "رحلة منتهية",
  "تم الغاء الرحلة"
];
List<Color> statusTripColor = [
  Colors.orange,
  Colors.green,
  Colors.grey,
  Colors.red
];
