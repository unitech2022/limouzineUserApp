import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/functions.dart';
import '../../../core/routers/routers.dart';
import '../../../core/styles/colors.dart';
import '../../../core/utlis/app_model.dart';
import '../../../core/utlis/enums.dart';
import '../../../data/models/booking_response.dart';
import '../../../domin/entities/city.dart';
import '../../controller/trip_cubit/trip_cubit.dart';
import '../login_screen/login_screen.dart';
import '../notifications_screen/notifications_screen.dart';
import 'booking_details.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    TripCubit.get(context).getMyBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffEAEB15),
        title: Text("حجوزاتى".tr(), style: TextStyle(color: Colors.black)),
        leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: BlocBuilder<TripCubit, TripState>(builder: (context, state) {
        return state.getBookingsState == RequestState.loading
            ? Center(child: LoadingWidget(height: 55, color: homeColor))
            : ListBookingWidget(bookings: state.responseBookings!);
      }),
    );
  }
}

class ListBookingWidget extends StatelessWidget {
  final List<BookingResponse> bookings;
   ListBookingWidget({
    super.key,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, left: 11, right: 11, bottom: 20),
      child: bookings.isEmpty
          ? ListEmptyWidget(textColor: Colors.black, title: "لا توجد حجوزات".tr())
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (ctx, index) {
                BookingResponse bookingsResponse = bookings[index];
                  City startCity =cities.firstWhere((element) =>element.name==bookingsResponse.trip!.startCity );
                          City endCity =cities.firstWhere((element) =>element.name==bookingsResponse.trip!.endCity );
                return GestureDetector(

                
                  onTap: () {
                    pushPage(
                        context: context,
                        page: BookingDetailsScreen(
                          groupId: bookingsResponse.trip!.id,
                          bookingId: bookingsResponse.booking!.id!,
                        ));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(11),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "#${bookingsResponse.booking!.id!.toString()}",
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: Color(0xfffe7811),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      'محطة الذهاب'.tr(),
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
                                    width: 20,
                                  ),
                                  Text(
                                   AppModel.lang=="ar"?startCity.name!:startCity.name_eng!,
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 13,
                                      color: const Color(0xff7d756e),
                                    ),
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 26,
                                decoration: BoxDecoration(
                                  color:colors[bookingsResponse.booking!.status!],
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                                child: Center(
                                    child: Text(
                                  bookStatus[bookingsResponse.booking!.status!],
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 12,
                                    color: const Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.start,
                                )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "محطة الوصول".tr(),
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
                                width: 20,
                              ),
                              Text(
                               AppModel.lang=="ar"?endCity.name!:endCity.name_eng!,
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
                                  color: const Color(0xff7d756e),
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      "تاريخ الرحلة".tr(),
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
                                    width: 20,
                                  ),
                                  Text(
                                    bookingsResponse.trip!.startingAt
                                        .split("T")[0],
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 13,
                                      color: const Color(0xff7d756e),
                                    ),
                                    textAlign: TextAlign.right,
                                  )
                                ],
                              ),
                              Text(
                                '${bookingsResponse.trip!.price} ٍٍSR',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 16,
                                  color: const Color(0xfff20000),
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  "وقت الرحلة".tr(),
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
                                width: 20,
                              ),
                              Text(
                                bookingsResponse.trip!.startingAt
                                        .split("T")[1] +
                                    " - " +
                                    bookingsResponse.trip!.endTime
                                        .split("T")[1],
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 13,
                                  color: const Color(0xff7d756e),
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          )
                        ],
                      )),
                );
              }),
    );
  }

  List<Color> colors = [Colors.amber, Colors.green, Colors.red];

   List<String> bookStatus = ['في الانتظار'.tr(), 'مؤكد'.tr(),  'ملغي'.tr()];
}
