import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/helpers/functions.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/enums.dart';
import '../../../core/widgets/circle_image_widget.dart';
import '../../../data/models/external_details.dart';
import '../../../domin/entities/city.dart';
import '../../controller/trip_cubit/trip_cubit.dart';
import '../external_trip_screen/external_trip_screen.dart';

import '../login_screen/login_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  final int groupId,  bookingId;
  const BookingDetailsScreen(
      {super.key,
      required this.groupId,
     
      required this.bookingId});

  @override
  State<BookingDetailsScreen> createState() =>
      _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    TripCubit.get(context).getExternalTripDetails(groupId: widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffEAEB15),
        title:
            Text("تفاصيل الرحلة".tr(), style: TextStyle(color: Colors.black)),
        leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: BlocBuilder<TripCubit, TripState>(builder: (context, state) {
        return state.getGroupDetailsState == RequestState.loading
            ? Center(child: LoadingWidget(height: 55, color: homeColor))
            : SingleChildScrollView(
                child: DetailsTripWedgit(
                    externalDetails: state.groupDetails!,
                   
                    bookingId: widget.bookingId),
              );
      }),
    );
  }
}

// class ListBookingWidget extends StatelessWidget {
//   final List<BookingsResponse> bookings;
//   const ListBookingWidget({
//     super.key,
//     required this.bookings,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 30, left: 11, right: 11, bottom: 20),
//       child: bookings.isEmpty
//           ? ListEmptyWidget(textColor: Colors.black, title: "لا توجد حجوزات")
//           : ListView.builder(
//               itemCount: bookings.length,
//               itemBuilder: (ctx, index) {
//                 BookingsResponse bookingsResponse = bookings[index];
//                 return Container(
//                     padding: const EdgeInsets.all(11),
//                     margin: EdgeInsets.only(bottom: 5),
//                     decoration: BoxDecoration(
//                       color: const Color(0xffffffff),
//                       borderRadius: BorderRadius.circular(12.0),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Color(0x29000000),
//                           offset: Offset(0, 3),
//                           blurRadius: 6,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "#${bookingsResponse.booking!.id!.toString()}",
//                               style: TextStyle(
//                                 fontFamily: 'Segoe UI',
//                                 fontSize: 16,
//                                 color: Color(0xfffe7811),
//                               ),
//                               textAlign: TextAlign.right,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 launchUrl(Uri.parse(
//                                     "tel://${bookingsResponse.userDetail!.userName}"));
//                               },
//                               child: Container(
//                                 height: 35,
//                                 width: 35,
//                                 decoration: BoxDecoration(
//                                     color: Colors.blue, shape: BoxShape.circle),
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.call,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: 60,
//                               child: Text(
//                                 'الاسم'.tr(),
//                                 style: TextStyle(
//                                   fontFamily: 'Segoe UI',
//                                   fontSize: 13,
//                                   color: const Color(0xff000000),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 textAlign: TextAlign.right,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               bookingsResponse.userDetail!.fullName!,
//                               style: TextStyle(
//                                 fontFamily: 'Segoe UI',
//                                 fontSize: 13,
//                                 color: const Color(0xff7d756e),
//                               ),
//                               textAlign: TextAlign.right,
//                             )
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 SizedBox(
//                                   width: 60,
//                                   child: Text(
//                                     'رقم الهاتف'.tr(),
//                                     style: TextStyle(
//                                       fontFamily: 'Segoe UI',
//                                       fontSize: 13,
//                                       color: const Color(0xff000000),
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                     textAlign: TextAlign.right,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Text(
//                                   bookingsResponse.userDetail!.userName!,
//                                   style: TextStyle(
//                                     fontFamily: 'Segoe UI',
//                                     fontSize: 13,
//                                     color: const Color(0xff7d756e),
//                                   ),
//                                   textAlign: TextAlign.right,
//                                 )
//                               ],
//                             ),
//                             BlocBuilder<TripCubit, TripState>(
//                                 builder: (context, state) {
//                               return bookingsResponse.booking!.status == 0
//                                   ? state.acceptExternalTrip ==
//                                           RequestState.loading
//                                       ? LoadingWidget(
//                                           height: 26, color: homeColor)
//                                       : Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 TripCubit.get(context)
//                                                     .acceptExternalTrip(
//                                                         bookingId:
//                                                             bookingsResponse
//                                                                 .booking!.id,
//                                                         status: 1);
//                                               },
//                                               child: Container(
//                                                 height: 26,
//                                                 width: 58,
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       const Color(0xff0fd937),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           23.0),
//                                                 ),
//                                                 child: Center(
//                                                     child: Text(
//                                                   'قبول'.tr(),
//                                                   style: TextStyle(
//                                                     fontFamily: 'Segoe UI',
//                                                     fontSize: 16,
//                                                     color:
//                                                         const Color(0xffffffff),
//                                                   ),
//                                                   textAlign: TextAlign.right,
//                                                 )),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 TripCubit.get(context)
//                                                     .acceptExternalTrip(
//                                                         bookingId:
//                                                             bookingsResponse
//                                                                 .booking!.id,
//                                                         status: 2);
//                                               },
//                                               child: Container(
//                                                 height: 26,
//                                                 width: 58,
//                                                 decoration: BoxDecoration(
//                                                   color:
//                                                       const Color(0xffD90F0F),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           23.0),
//                                                 ),
//                                                 child: Center(
//                                                     child: Text(
//                                                   'رفض'.tr(),
//                                                   style: TextStyle(
//                                                     fontFamily: 'Segoe UI',
//                                                     fontSize: 16,
//                                                     color:
//                                                         const Color(0xffffffff),
//                                                   ),
//                                                   textAlign: TextAlign.right,
//                                                 )),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                   : Container(
//                                       height: 26,
//                                       width: 58,
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xff0fd937),
//                                         borderRadius:
//                                             BorderRadius.circular(23.0),
//                                       ),
//                                       child: Center(
//                                           child: Text(
//                                         bookingsResponse.booking!.status == 1
//                                             ? 'مؤكد'.tr()
//                                             : 'مرفوض'.tr(),
//                                         style: TextStyle(
//                                           fontFamily: 'Segoe UI',
//                                           fontSize: 16,
//                                           color: const Color(0xffffffff),
//                                         ),
//                                         textAlign: TextAlign.right,
//                                       )),
//                                     );
//                             })
//                           ],
//                         ),
//                       ],
//                     ));
//               }),
//     );
//   }
// }

class DetailsTripWedgit extends StatelessWidget {
  final ExternalDetails externalDetails;
  final int  bookingId;
  DetailsTripWedgit(
      {super.key,
      required this.externalDetails,
    
      required this.bookingId});

  @override
  Widget build(BuildContext context) {

          City startCity =cities.firstWhere((element) =>element.name==externalDetails.trip!.startCity );
                          City endCity =cities.firstWhere((element) =>element.name==externalDetails.trip!.endCity );
    return Container(
        margin: EdgeInsets.only(top: 20, left: 11, right: 11),
        child: Column(children: [
          Padding(
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
                padding: EdgeInsets.all(11),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          externalDetails.trip!.name,
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: const Color(0xfffe7811),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          '${externalDetails.trip!.price} ٍٍSR',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 16,
                            color: const Color(0xfff20000),
                          ),
                          textAlign: TextAlign.right,
                        )
                      ],
                    ),
                    RowDetailsTrip(
                        title: 'محطة الذهاب'.tr(),
                        value:AppModel.lang=="ar"?startCity.name!:startCity.name_eng!,
                        child: SizedBox()
                        //  Text(
                        //   '${externalTrip.startingAt.split('T')[0]}  -  05:20',
                        //   style: TextStyle(
                        //     fontFamily: 'Segoe UI',
                        //     fontSize: 17,
                        //     color: const Color(0xff03de79),
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        //   textAlign: TextAlign.right,
                        // ),
                        ),
                         SizedBox(height: 5,),
                    RowDetailsTrip(
                      title: "محطة الوصول".tr(),
                      value:AppModel.lang=="ar"?endCity.name!:endCity.name_eng!,
                      child: SizedBox(),
                    ),
                    SizedBox(height: 5,),
                    RowDetailsTrip(
                      title: "تاريخ الرحلة".tr(),
                      value: externalDetails.trip!.startingAt.split("T")[0] +
                          " , " +
                          externalDetails.trip!.startingAt.split("T")[1],
                      child: SizedBox(),
                    ),
                     SizedBox(height: 5,),
                    RowDetailsTrip(
                      title: "عدد الركاب".tr(),
                      value: externalDetails.trip!.sets.toString(),
                      child: SizedBox(),
                    ),
                  ],
                )),
          ),

//** driverDetails */
          Padding(
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
                padding: EdgeInsets.all(11),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "السائق".tr(),
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 20,
                            color: const Color(0xfffe7811),
                          ),
                          textAlign: TextAlign.right,
                        ),

                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(
                                "tel://${externalDetails.profileDriver!.userName}"));
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                   SizedBox(height: 5,),
                    RowDetailsTrip(
                      title: "الاسم".tr(),
                      value: externalDetails.profileDriver!.fullName!,
                      child: SizedBox(),
                    ),
                     SizedBox(height: 5,),
                    RowDetailsTrip(
                      title: "رقم الهاتف".tr(),
                      value: externalDetails.profileDriver!.userName!,
                      child: SizedBox(),
                    ),
                     SizedBox(height: 5,),
                    RowDetailsTrip(
                      title: "عدد الركاب".tr(),
                      value: externalDetails.trip!.sets.toString(),
                      child: SizedBox(),
                    ),
                  ],
                )),
          ),

          SizedBox(
            height: 50,
          ),

          // *** location trip
          Container(
            padding: EdgeInsets.all(20),
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
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'الموقع'.tr(),
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 20,
                        color: const Color(0xfffe7811),
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 91,
                          width: 91,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.circle),
                                child: CircleImageWidget(
                            height: 90,
                            width: 90,
                            icon: Icons.location_on_outlined,
                            image:
                                "https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${externalDetails.trip!.startPointLat},${externalDetails.trip!.startPointLng}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4",
                          ),
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        GestureDetector(
                          onTap: () {
                            openGoogleMapLocation(
                                lat: externalDetails.trip!.startPointLat,
                                lng: externalDetails.trip!.startPointLng);
                          },
                          child: Container(
                            height: 25,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xff1485f6),
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                            child: Center(
                              child: Text(
                                'الذهاب'.tr(),
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
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 91,
                          width: 91,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.circle),

                                child: CircleImageWidget(
                            height: 90,
                            width: 90,
                            icon: Icons.location_on_outlined,
                            image:
                                "https://maps.googleapis.com/maps/api/staticmap?zoom=18&size=600x300&maptype=roadmap&markers=${externalDetails.trip!.endPointLat},${externalDetails.trip!.endPointLng}&key=AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4",
                          ),
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        GestureDetector(
                          onTap: () {
                            openGoogleMapLocation(
                                lat: externalDetails.trip!.endPointLat,
                                lng: externalDetails.trip!.endPointLng);
                          },
                          child: Container(
                            height: 25,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                            child: Center(
                              child: Text(
                                'الوصول'.tr(),
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
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),

          // ** operation trip
          SizedBox(
            height: 37,
          ),
       BlocBuilder<TripCubit, TripState>(builder: (context, state) {
            return state.acceptExternalTrip == RequestState.loading 
                ? LoadingWidget(height: 50, color: homeColor)
                : GestureDetector(
                    onTap: () {
                     
                        if (externalDetails.isBooking!) {
                          TripCubit.get(context).acceptExternalTrip(
                              bookingId: bookingId, status: 2,tripId: externalDetails.trip!.id);
                        } else {
                          TripCubit.get(context).acceptExternalTrip(
                              bookingId: bookingId, status: 0,tripId: externalDetails.trip!.id);
                        }
                      
                    },
                    child: Container(
                      height: 40,
                      child: Center(
                        child: Text(
                         externalDetails.isBooking!? "الغاء الحجز".tr():"احجز الآن".tr() ,
                          style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 20,
                              color: externalDetails.isBooking!
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                              height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
          })
        ]));
  }


}
