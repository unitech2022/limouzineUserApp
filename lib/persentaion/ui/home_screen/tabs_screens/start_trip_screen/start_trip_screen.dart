import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/helpers/helper_functions.dart';
import 'package:taxi/core/routers/routers.dart';
import 'package:taxi/core/utlis/api_constatns.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:taxi/core/utlis/data.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:taxi/core/widgets/circle_image_widget.dart';
import 'package:taxi/domin/entities/address_model.dart';
import 'package:taxi/domin/entities/car_type.dart';
import 'package:taxi/domin/entities/trip.dart';
import 'package:taxi/persentaion/controller/app_cubit/cubit/app_cubit.dart';
import 'package:taxi/persentaion/controller/home_cubit/cubit/home_cubit.dart';
import 'package:taxi/persentaion/controller/map_cubit%20copy/map_cubit.dart';
import 'package:taxi/persentaion/controller/trip_cubit/trip_cubit.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/thems/them.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/container.divider.dart';
import '../../../../../core/widgets/texts.dart';
import '../../components/app_bar_home.dart';
import '../../components/drawer_widget.dart';
import '../../map_screen.dart';
import '../trip_summary_screen/components/container_trip_summery.dart';
import 'components/container_input_address.dart';
import 'components/item_saved_addresses.dart';
import 'components/item_trip_type.dart';

class StartTripScreen extends StatefulWidget {
  const StartTripScreen({super.key});

  @override
  State<StartTripScreen> createState() => _StartTripScreenState();
}

class _StartTripScreenState extends State<StartTripScreen> {
  int carTypeId = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;

  final LatLng _center =
      LatLng(locData.latitude ?? 0.0, locData.longitude ?? 0.0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(styleMap);
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  void initState() {
    super.initState();
    TripCubit.get(context).updateDeviceToken(
        userId: currentUser.id!, token: AppModel.deviceToken);
    TripCubit.get(context)
        .getStartPointAddress(lat: locData.latitude, lng: locData.longitude,context: context);

         

    TripCubit.get(context).getCarTypes();
    TripCubit.get(context).homeTrip();
    getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            key: _scaffoldKey,
            drawer: DrawerWidget(
              scaffoldKey: _scaffoldKey,
            ),
            body: Stack(
              children: [
                // container select addresses trip
                BlocBuilder<MapCubit, MapState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 300.0),
                      child: CustomGoogleMapMarkerBuilder(
                          customMarkers: [
                            if(state.startPoint!=null)
                            getMarkerWidget(state.startPoint!, 1),
                            if(state.endPoint!=null)
                            getMarkerWidget(state.endPoint!, 2)
                          ],
                          builder: (context, markers) {
                            if (markers == null || locData.latitude == null) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: buttonsColor,
                              ));
                            }

                            return GoogleMap(
                              zoomControlsEnabled: false,
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 19.0,
                              ),
                              markers: markers,
                              polylines:  state.polyines,
                            );
                          }),
                    );
                  },
                ),

                BlocBuilder<TripCubit, TripState>(
                  builder: (context, state) {
                    return InternalTripWidget(state);
                  },
                )
                // app bar
                ,
                Positioned(
                  top: 53,
                  left: 24,
                  right: 24,
                  child: AppBarHome(
                    onTap: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                )
              ],
            ));
     
  }

  void getFCMToken() async {
    FirebaseMessaging.instance.getToken().then((token) {
      print(token.toString() + "tokrrrrrrn");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // NotifyAowsome(notification!.title!,notification.body!);
      if (notification != null && android != null && !kIsWeb) {
        TripCubit.get(context).homeTrip();
        // AwesomeNotifications().createNotification(
        //
        //     content: NotificationContent(
        //       id: createUniqueId(),
        //
        //       color: homeColor,
        //       icon: 'resource://drawable/ic_launcher',
        //
        //       channelKey: 'key1',
        //       title:
        //       '${Emojis.money_money_bag + Emojis.plant_cactus}${notification.title}',
        //       body: notification.body,
        //       bigPicture: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        //       notificationLayout: NotificationLayout.BigPicture,
        //       // largeIcon: "asset://assets/images/logo_final.png"
        //     ));

        // AwesomeNotifications().initialize(
        //     "asset://assets/images/logo_final",
        //     [
        //       NotificationChannel(
        //           channelKey: 'key1',
        //           channelName: 'chat',
        //           channelDescription: "Notification example",
        //           defaultColor: Colors.blue,
        //           ledColor: Colors.blue,
        //           channelShowBadge: true,
        //           playSound: true,
        //           enableLights:true,
        //           enableVibration: false
        //       )
        //     ]
        // );

/*        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            "تم اضافة اعلان في الاعلانات المعلقة",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
              ),
            ));*/

        print("aaaaaaaaaaaawww${message.data["desc"]}");
      }
    });
  }

  MarkerData getMarkerWidget(AddressModel addressModel, int id) {
    return MarkerData(
        marker: Marker(
            markerId: MarkerId('id-$id'),
            position: LatLng(addressModel.lat, addressModel.lng)),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(4),
            //     border: Border.all(
            //         color: Colors.white, width: .8)),
            child: Column(
              children: [
                Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: textColor, width: 2)),
                    child: CircleImageWidget(
                      height: 35,
                      width: 35,
                      image: ApiConstants.imageUrl(currentUser.profileImage),
                    )),
                Container(
                  color: homeColor,
                  width: 100,
                  margin: EdgeInsets.only(top: 4),
                  child: Text(addressModel.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 8, color: Colors.white)),
                ),
              ],
            )));
  }
}

class ListCarTypes extends StatefulWidget {
  List<CartType> carTypes;
  final Function(int) carTypeId;
  ListCarTypes(this.carTypes, this.carTypeId);

  @override
  State<ListCarTypes> createState() => _ListCarTypesState();
}

class _ListCarTypesState extends State<ListCarTypes> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, stateApp) {
        return ListView.builder(
            itemCount: widget.carTypes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AppCubit.get(context).changeValue(widget.carTypes[index].id);

                  setState(() {});
                  widget.carTypeId(widget.carTypes[index].id);
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: .5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            border: Border.all(color: homeColor, width: 1),
                            shape: BoxShape.circle),
                        child: Container(
                          height: 14,
                          width: 14,
                          margin: EdgeInsets.all(.5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppCubit.get(context).selectedRadio ==
                                      widget.carTypes[index].id
                                  ? homeColor
                                  : Colors.white),
                        ),
                      ),
                      sizedWidth(10),
                      CachedNetworkImage(
                        imageUrl:
                            ApiConstants.imageUrl(widget.carTypes[index].image),
                        height: 40,
                        width: 40,
                      ),
                      sizedWidth(15),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Texts(
                                title: widget.carTypes[index].name,
                                textColor: Colors.black,
                                fontSize: 15,
                                weight: FontWeight.normal,
                                align: TextAlign.start),
                            Texts(
                                title: widget.carTypes[index].sets.toString(),
                                textColor: Colors.black,
                                fontSize: 15,
                                weight: FontWeight.normal,
                                align: TextAlign.start),
                          ],
                        ),
                      ),
                      Texts(
                          title:
                              " ر س " + widget.carTypes[index].price.toString(),
                          textColor: Colors.black,
                          fontSize: 15,
                          weight: FontWeight.bold,
                          align: TextAlign.start),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

class InternalTripWidget extends StatelessWidget {
  final TripState state;
  InternalTripWidget(this.state);
  int carTypeId = 0;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: state.homeState == RequestState.loading
          ? LoadingWidget(height: 380, color: buttonsColor)
          : state.responseHome!.tripActive
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Colors.white),
                  child: Column(
                    children: [
                      sizedHeight(13),
                      const ContainerDivider(
                        color: Color(0xffBEBEBE),
                        height: 3,
                        width: 120,
                      ),
                      sizedHeight(13),

                      // show trip details
                      state.responseHome!.trip!.driverId != 0 &&
                              state.responseHome!.trip!.status != 0
                          ? Column(
                              children: [
                                Texts(
                                    title: state.responseHome!.trip!.status == 1
                                        ? Strings.ridWiyh +
                                            "  " +
                                            state.responseHome!.driverDetail!
                                                .fullName!
                                        : statuesTrip[
                                            state.responseHome!.trip!.status],
                                    textColor: Colors.black,
                                    fontSize: 16,
                                    weight: FontWeight.bold,
                                    align: TextAlign.center),
                                sizedHeight(13),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: CachedNetworkImage(
                                        imageUrl: ApiConstants.imageUrl(state
                                            .responseHome!
                                            .driverDetail!
                                            .profileImage),
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    sizedWidth(20),
                                    Expanded(
                                      child: Texts(
                                          title: state.responseHome!
                                                  .driverDetail!.fullName! +
                                              "  ",
                                          textColor: Colors.black,
                                          fontSize: 16,
                                          weight: FontWeight.bold,
                                          align: TextAlign.start),
                                    )
                                  ],
                                )

                                // details trip
                                ,
                                sizedHeight(6),
                                ContainerTripSummery(
                                  title: Strings.starting.tr(),
                                  value: state.responseHome!.trip!.startAddress,
                                ),
                                sizedHeight(6),
                                ContainerTripSummery(
                                  title: Strings.arrive.tr(),
                                  value: state.responseHome!.trip!.endAddress,
                                ),
                                sizedHeight(100),
                                state.responseHome!.trip!.status < 3
                                    ? state.changeStatusTrip ==
                                            RequestState.loading
                                        ? LoadingWidget(
                                            height: 55, color: homeColor)
                                        : ButtonWidget(
                                            height: 55,
                                            color: buttonsColor,
                                            onPress: () {
                                              print(state.statues.toString() +
                                                  "ojnbj");
                                              TripCubit.get(context)
                                                  .changeStatusTrip(
                                                      tripId:
                                                          state.responseHome!
                                                              .trip!.id,
                                                      status: state
                                                                  .responseHome!
                                                                  .trip!
                                                                  .status ==
                                                              2
                                                          ? 3
                                                          : 7,
                                                      userId: state
                                                          .responseHome!
                                                          .driver!
                                                          .userId);
                                            },
                                            child: Texts(
                                                title: state.responseHome!.trip!
                                                            .status ==
                                                        2
                                                    ? Strings.searchAboutTrip
                                                    : Strings.cancelTrip.tr(),
                                                textColor: Colors.white,
                                                fontSize: 14,
                                                weight: FontWeight.normal,
                                                align: TextAlign.center))
                                    : SizedBox(),
                                sizedHeight(6),
                              ],
                            )
                          // trip waiting
                          : SizedBox(
                              child: Column(
                              children: [
                                sizedHeight(40),
                                Texts(
                                    title: state.timerTrip == 100
                                        ? Strings.thereNotDriver.tr()
                                        : Strings.searchTodriver.tr(),
                                    textColor: Colors.black,
                                    fontSize: 14,
                                    weight: FontWeight.normal,
                                    align: TextAlign.center),
                                sizedHeight(40),
                                LinearPercentIndicator(
                                  barRadius: Radius.circular(30),
                                  width: 300,
                                  lineHeight: 8,
                                  backgroundColor: Colors.grey,
                                  progressColor: homeColor,
                                  percent:
                                      double.parse("${state.timerTrip}") / 100,
                                ),
                                sizedHeight(100),
                                state.changeStatusTrip == RequestState.loading
                                    ? LoadingWidget(
                                        height: 55, color: homeColor)
                                    : ButtonWidget(
                                        height: 55,
                                        color: buttonsColor,
                                        onPress: () {
                                          print(state.statues.toString() +
                                              "ojnbj");
                                          if (TripCubit.get(context)
                                              .timer!
                                              .isActive) {
                                            TripCubit.get(context)
                                                .cancelTimer();
                                          }
                                          TripCubit.get(context)
                                              .changeStatusTrip(
                                                  tripId: state
                                                      .responseHome!.trip!.id,
                                                  status: 7,
                                                  isState: 0,
                                                  userId: state.responseHome!
                                                              .trip!.driverId ==
                                                          0
                                                      ? currentUser.id!
                                                      : state.responseHome!
                                                          .driver!.userId);
                                        },
                                        child: Texts(
                                            title: Strings.cancelTrip.tr(),
                                            textColor: Colors.white,
                                            fontSize: 14,
                                            weight: FontWeight.normal,
                                            align: TextAlign.center)),
                                sizedHeight(20)
                              ],
                            )),
                    ],
                  ),
                )
              :

              //  no trip active
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  width: double.infinity,
                  height: 370,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: state.statues == 1
                      ? Column(
                          children: [
                            sizedHeight(13),
                            const ContainerDivider(
                              color: Color(0xffBEBEBE),
                              height: 3,
                              width: 120,
                            ),
                            sizedHeight(20),
                            Row(
                              children: [
                                Texts(
                                    title: "اختار نوع السيارة",
                                    textColor: Colors.black,
                                    fontSize: 15,
                                    weight: FontWeight.normal,
                                    align: TextAlign.start),
                              ],
                            ),
                            sizedHeight(0),
                            Expanded(
                              child: ListCarTypes(state.carTypes, (typeId) {
                                carTypeId = typeId;
                              }),
                            ),
                            state.addTripState == RequestState.loading
                                ? LoadingWidget(
                                    color: buttonsColor,
                                    height: 55,
                                  )
                                : ButtonWidget(
                                    height: 55,
                                    color: buttonsColor,
                                    onPress: () {
                                      Trip trip = Trip(
                                          carId: carTypeId,
                                          startPointLat: state.startPoint!.lat,
                                          startPointLng: state.startPoint!.lng,
                                          endPointLat: state.endPoint!.lat,
                                          endPointLng: state.endPoint!.lng,
                                          startAddress: state.startPoint!.label,
                                          endAddress: state.endPoint!.label,
                                          otp: "000",
                                          status: 0,
                                          payment: 0,
                                          price: 30,
                                          createdAt: '',
                                          driverId: 0,
                                          id: 0,
                                          userId: currentUser.id!);

                                      TripCubit.get(context).addTrip(trip);

                                      //todo : addTrip
                                    },
                                    child: Texts(
                                        title: Strings.searchAboutTrip.tr(),
                                        textColor: Colors.white,
                                        fontSize: 14,
                                        weight: FontWeight.normal,
                                        align: TextAlign.center)),
                          ],
                        )
                      : Column(children: [
                          sizedHeight(13),
                          const ContainerDivider(
                            color: Color(0xffBEBEBE),
                            height: 3,
                            width: 120,
                          ),
                          sizedHeight(15),

                          // List Type Trip
                          SizedBox(
                            height: 65,
                            child: ListView.builder(
                                itemCount: typesTrip.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  TypeTrip typeTrip = typesTrip[index];
                                  return InkWell(
                                      onTap: () {
                                        TripCubit.get(context)
                                            .changeIndexTypeTrip(typeTrip.id);
                                      },
                                      child: ItemTripType(
                                          typeTrip: typeTrip,
                                          currentIndex:
                                              state.currentIndexTypeTrip));
                                }),
                          ),
                          sizedHeight(13),

                          // select start and end of trip
                          SizedBox(
                              height: 120,
                              child: Stack(children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: ContainerInputAddress(
                                      title: Strings.starting.tr(),
                                      value: state.startPoint != null
                                          ? state.startPoint!.label
                                          : Strings.whenStarting.tr(),
                                      addAddressWidget: const SizedBox(),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          // Create the SelectionScreen in the next step.
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectAddressScreen()),
                                        ).then((value) {
                                          TripCubit.get(context)
                                              .getStartLocation(
                                                  value as AddressModel);
                                          MapCubit.get(context)
                                              .getStartLocation(value);
                                        });
                                      },
                                    )),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ContainerInputAddress(
                                      title: Strings.end.tr(),
                                      value: Strings.whenEnd.tr(),
                                      addAddressWidget: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        print("object");

                                        Navigator.push(
                                          context,
                                          // Create the SelectionScreen in the next step.
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectAddressScreen()),
                                        ).then((value) {
                                          TripCubit.get(context).getEndLocation(
                                              value as AddressModel);
                                        });
                                      },
                                    )),
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        height: 36,
                                        width: 36,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffA5A5A5),
                                            shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                          "assets/icons/sync_alt.svg",
                                          width: 20,
                                          height: 18,
                                        )),
                                  ),
                                )
                              ])),

                          sizedHeight(13),
                          // list saved Addresses
                          // SizedBox(
                          //   height: 63,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: addresses.length,
                          //       itemBuilder: (context, index) {
                          //         TypeTrip address = addresses[index];

                          //         return ItemSavedAddresses(
                          //           address: address,
                          //         );
                          //       }),
                          // ),

                          const Spacer()
                          // button search
                          ,
                          ButtonWidget(
                              height: 55,
                              color: buttonsColor,
                              onPress: () {
                                print("object");

                                if (state.startPoint != null) {
                                  Navigator.push(
                                    context,
                                    // Create the SelectionScreen in the next step.
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectAddressScreen()),
                                  ).then((value) {
                                    TripCubit.get(context)
                                        .getEndLocation(value as AddressModel,context: context);
                                    MapCubit.get(context).getEndLocation(value);
                                  });
                                } else {
                                  showToast(message: "اختار البداية");
                                }
                              },
                              child: Texts(
                                  title: Strings.searchAboutTrip.tr(),
                                  textColor: Colors.white,
                                  fontSize: 14,
                                  weight: FontWeight.normal,
                                  align: TextAlign.center)),
                        ]),
                ),
    );
  }
}
