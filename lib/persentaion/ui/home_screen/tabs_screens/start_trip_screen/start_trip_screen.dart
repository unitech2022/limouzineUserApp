import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/utlis/api_constatns.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:taxi/core/widgets/circle_image_widget.dart';
import 'package:taxi/domin/entities/address_model.dart';
import 'package:taxi/persentaion/controller/map_cubit%20copy/map_cubit.dart';
import 'package:taxi/persentaion/controller/trip_cubit/trip_cubit.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/thems/them.dart';
import '../../components/app_bar_home.dart';
import '../../components/drawer_widget.dart';
import 'components/internal_trip_widget.dart';

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
    getFCMToken();
    TripCubit.get(context).updateDeviceToken(
        userId: currentUser.id!, token: AppModel.deviceToken);
    TripCubit.get(context).getStartPointAddress(
        lat: locData.latitude, lng: locData.longitude, context: context);

    TripCubit.get(context).getCarTypes();
    TripCubit.get(context).homeTrip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        if (state.startPoint != null)
                          getMarkerWidget(state.startPoint!, 1),
                        if (state.endPoint != null)
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
                          polylines: state.polyines,
                        );
                      }),
                );
              },
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<TripCubit, TripState>(
                builder: (context, state) {
                  return WillPopScope(
                      onWillPop: () async {
                        if (state.statues != 0) {
                          TripCubit.get(context)
                              .changeStatusScreen(state.statues - 1);
                        }
                        return false;
                      },
                      child: SizedBox(child: InternalTripWidget(state)));
                },
              ),
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
        , Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                         TripCubit.get(context).homeTrip();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      shape: BoxShape.circle
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(20.0),
                    child: 
                       Icon(Icons.refresh,color: Colors.white,),
                      
                    
                  ),
                )),
        
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
        print("tokrrrrrrnseneeeeee");
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

        AwesomeNotifications().createNotification(
            content: NotificationContent(
          id: createUniqueId(),

          color: Colors.blue,

          channelKey: 'limozin',
          title: notification.title,
          body: notification.body,

          notificationLayout: NotificationLayout.BigPicture,
          // largeIcon: "asset://assets/images/logo_final.png"
        ));

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

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
