import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/enums.dart';
import '../../../core/utlis/strings.dart';

import '../../../data/models/external_trip.dart';
import '../../../domin/entities/city.dart';
import '../../controller/trip_cubit/trip_cubit.dart';

import '../external_details_screen/external_trip_detials_screen.dart';
import '../login_screen/login_screen.dart';
import '../notifications_screen/notifications_screen.dart';

class ExternalTripScreen extends StatefulWidget {
  final String startCity, endCity, date;
  ExternalTripScreen(
      {super.key,
      required this.startCity,
      required this.endCity,
      required this.date});

  @override
  State<ExternalTripScreen> createState() => _ExternalTripScreenState();
}

class _ExternalTripScreenState extends State<ExternalTripScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print(widget.date);
    TripCubit.get(context).getExternalTrips(
        startCity: widget.startCity,
        date: widget.date,
        endCity: widget.endCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffEAEB15),
        title: Text("نتائج البحث".tr(), style: TextStyle(color: Colors.black)),
        leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: BlocBuilder<TripCubit, TripState>(
        builder: (context, state) {
          return state.getExternalTripsState == RequestState.loading
              ? Center(
                  child: LoadingWidget(height: 55, color: homeColor),
                )
              : state.externalTrips!.isEmpty
                  ? ListEmptyWidget(
                      textColor: homeColor, title: Strings.notTrips.tr())
                  : ListView.builder(
                      itemCount: state.externalTrips!.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      itemBuilder: (ctx, index) {
                        ExternalTrip externalTrip = state.externalTrips![index];

                          City startCity =cities.firstWhere((element) =>element.name==externalTrip.startCity );
                          City endCity =cities.firstWhere((element) =>element.name==externalTrip.endCity );

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        externalTrip.name,
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 20,
                                          color: const Color(0xfffe7811),
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                        '${externalTrip.price} ٍٍSR',
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 16,
                                          color: const Color(0xfff20000),
                                        ),
                                        textAlign: TextAlign.right,
                                      )
                                    ],
                                  ),

                              SizedBox(height: 5,),
                                RowDetailsTrip(
                                    title: 'محطة الذهاب'.tr(),
                                    value:AppModel.lang=="ar"?startCity.name!:startCity.name_eng!,
                                    child:SizedBox()
                                    
                                    //  Column(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     Text(
                                    //       externalTrip.startingAt,
                                    //       style: TextStyle(
                                    //         fontFamily: 'Segoe UI',
                                    //         fontSize: 17,
                                    //         color: const Color(0xff03de79),
                                    //         fontWeight: FontWeight.normal,
                                    //       ),
                                    //       textAlign: TextAlign.right,
                                    //     ),
                                    //     Text(
                                    //       externalTrip.endTime,
                                    //       style: TextStyle(
                                    //         fontFamily: 'Segoe UI',
                                    //         fontSize: 17,
                                    //         color: const Color(0xff03de79),
                                    //         fontWeight: FontWeight.normal,
                                    //       ),
                                    //       textAlign: TextAlign.right,
                                    //     ),
                                    //   ],
                                    // ),
                                  
                                  
                                  ),
SizedBox(height: 5,),

                                  RowDetailsTrip(
                                    title: "محطة الوصول".tr(),
                                    value:AppModel.lang=="ar"?endCity.name!:endCity.name_eng! ,
                                    child: SizedBox(),
                                  ),
SizedBox(height: 5,),

                                  RowDetailsTrip(
                                    title: "تاريخ الرحلة".tr(),
                                    value: externalTrip.startingAt
                                            .split('T')[0] +
                                        " , " +
                                        externalTrip.startingAt.split('T')[1],
                                    child: SizedBox(),
                                  ),
SizedBox(height: 5,),

                                  RowDetailsTrip(
                                    title: "عدد الركاب".tr(),
                                    value: externalTrip.sets.toString(),
                                    child: GestureDetector(
                                      onTap: () {
                                        pushPage(
                                            context: context,
                                            page: ExternalTripDetailsScreen(
                                              groupId: externalTrip.id,
                                              bookingId: 1,
                                            ));
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 80,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff1485f6),
                                          borderRadius:
                                              BorderRadius.circular(23.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'عرض'.tr(),
                                            style: TextStyle(
                                                fontFamily: 'Segoe UI',
                                                fontSize: 16,
                                                color: const Color(0xffffffff),
                                                height: 1.2),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
SizedBox(height: 5,),
                                  // starting point

                                  // sizedHeight(15),
                                  // GestureDetector(
                                  //   child: ContainerPointWidget(
                                  //     color: buttonsColor,
                                  //     width: 16,
                                  //     label: Strings.startPoint.tr(),
                                  //     value: externalTrip.startCity,
                                  //   ),
                                  // ),
                                  // sizedHeight(15),
                                  // ContainerPointWidget(
                                  //   width: 16,
                                  //   color: Color(0xff88D55F),
                                  //   label: Strings.endPoint.tr(),
                                  //   value: externalTrip.endCity,
                                  // ),
                                  // sizedHeight(10),
                                  // Row(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //   children: [
                                  //     Texts(
                                  //         title: Strings.numberPeoplesTrip.tr(),
                                  //         textColor: Colors.black,
                                  //         fontSize: 16,
                                  //         weight: FontWeight.normal,
                                  //         align: TextAlign.right),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Texts(
                                  //         title: externalTrip.sets.toString(),
                                  //         textColor: Colors.black,
                                  //         fontSize: 16,
                                  //         weight: FontWeight.normal,
                                  //         align: TextAlign.right),
                                  //   ],
                                  // ),
                                  // sizedHeight(10),
                                  // Row(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //   children: [
                                  //     Texts(
                                  //         title: Strings.cost.tr(),
                                  //         textColor: Colors.black,
                                  //         fontSize: 16,
                                  //         weight: FontWeight.normal,
                                  //         align: TextAlign.right),
                                  //     SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     Texts(
                                  //         title: " : ",
                                  //         textColor: Colors.black,
                                  //         fontSize: 16,
                                  //         weight: FontWeight.normal,
                                  //         align: TextAlign.right),
                                  //     Texts(
                                  //         title: externalTrip.price.toString(),
                                  //         textColor: Colors.black,
                                  //         fontSize: 16,
                                  //         weight: FontWeight.normal,
                                  //         align: TextAlign.right),
                                  //   ],
                                  // ),
                                ],
                              )),
                        );
                      });
        },
      ),
    );
  }
}

class RowDetailsTrip extends StatelessWidget {
  final String title, value;
  final Widget child;
  const RowDetailsTrip({
    super.key,
    required this.title,
    required this.value,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              // width: 80,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 13,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 13,
                color: const Color(0xff7d756e),
              ),
              textAlign: TextAlign.right,
            )
          ],
        ),
        child
      ],
    );
  }
}
