import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:taxi/persentaion/controller/trip_cubit/trip_cubit.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/thems/them.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/container.divider.dart';
import '../../../../../core/widgets/texts.dart';
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

  late GoogleMapController mapController;

  final LatLng _center = LatLng(locData.latitude!, locData.longitude!);

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

    TripCubit.get(context)
        .getStartPointAddress(lat: locData.latitude, lng: locData.longitude);

    TripCubit.get(context).getCarTypes();
    TripCubit.get(context).homeTrip();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) {
        return Scaffold(
            body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 300.0),
              child: CustomGoogleMapMarkerBuilder(
                  customMarkers: [
                    // MarkerData(
                    //     marker: Marker(
                    //         markerId: const MarkerId('id-1'),
                    //         position: LatLng(locData.latitude ?? 0.0,
                    //             locData.longitude ?? 0.0)),
                    //     child: Container(
                    //         height: 100,
                    //         width: 100,
                    //         color: Colors.white,
                    //         child: Text("aamms"))),
                  ],
                  builder: (context, markers) {
                    if (markers == null || locData.latitude == null) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return GoogleMap(
                      zoomControlsEnabled: false,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 14.0,
                      ),
                      markers: markers,
                    );
                  }),
            ),

            // container select addresses trip

            Align(
              alignment: Alignment.bottomCenter,
              child: state.homeState == RequestState.loading
                  ? LoadingWidget(height: 380, color: buttonsColor)
                  : state.responseHome!.tripActive
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
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
                            state.responseHome!.trip!.driverId !=0 ? Column(
                                children: [
                                     Texts(
                                  title: state
                                          .responseHome!.userDetail!.fullName! +
                                      "  " +
                                      Strings.ridWiyh,
                                  textColor: Colors.black,
                                  fontSize: 16,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center),
                              sizedHeight(13),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: CachedNetworkImage(imageUrl: ApiConstants.imageUrl(state
                                            .responseHome!
                                            .userDetail!
                                            .profileImage),width: 50,height: 50,),
                                  ),
                                  sizedWidth(20),
                                  Expanded(
                                    child: Texts(
                                        title: state.responseHome!.userDetail!
                                                .fullName! +
                                            "  " ,
                                           
                                        textColor: Colors.black,
                                        fontSize: 16,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start),
                                  )
                                ],
                              )
                                ],
                              ): SizedBox(),
                           
                              // details trip
                              
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
                              Spacer(),
                              ButtonWidget(
                                  height: 55,
                                  color: buttonsColor,
                                  onPress: () {
                                    //todo : addTrip
                                  },
                                  child: Texts(
                                      title: Strings.cancelTrip.tr(),
                                      textColor: Colors.white,
                                      fontSize: 14,
                                      weight: FontWeight.normal,
                                      align: TextAlign.center)),
                                       sizedHeight(6),
                            ],
                          ),
                        )
                      :
                      //  not trip
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
                                      child: ListCarTypes(state.carTypes,
                                          (typeId) {
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
                                                  startPointLat:
                                                      state.startPoint!.lat,
                                                  startPointLng:
                                                      state.startPoint!.lng,
                                                  endPointLat:
                                                      state.endPoint!.lat,
                                                  endPointLng:
                                                      state.endPoint!.lng,
                                                  startAddress:
                                                      state.startPoint!.label,
                                                  endAddress:
                                                      state.endPoint!.label,
                                                  otp: "000",
                                                  status: 0,
                                                  payment: 0,
                                                  price: 30,
                                                  createdAt: '',
                                                  driverId: 0,
                                                  id: 0,
                                                  userId: currentUser.id!);

                                              TripCubit.get(context)
                                                  .addTrip(trip);

                                              //todo : addTrip
                                            },
                                            child: Texts(
                                                title: Strings.searchAboutTrip
                                                    .tr(),
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
                                                    .changeIndexTypeTrip(
                                                        typeTrip.id);
                                              },
                                              child: ItemTripType(
                                                  typeTrip: typeTrip,
                                                  currentIndex: state
                                                      .currentIndexTypeTrip));
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
                                              addAddressWidget:
                                                  const SizedBox(),
                                              onTap: () {},
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
                                                  TripCubit.get(context)
                                                      .getEndLocation(value
                                                          as AddressModel);
                                                });
                                              },
                                            )),
                                        Align(
                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                  SizedBox(
                                    height: 63,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: addresses.length,
                                        itemBuilder: (context, index) {
                                          TypeTrip address = addresses[index];

                                          return ItemSavedAddresses(
                                            address: address,
                                          );
                                        }),
                                  ),
                                  const Spacer()
                                  // button search
                                  ,
                                  ButtonWidget(
                                      height: 55,
                                      color: buttonsColor,
                                      onPress: () {},
                                      child: Texts(
                                          title: Strings.searchAboutTrip.tr(),
                                          textColor: Colors.white,
                                          fontSize: 14,
                                          weight: FontWeight.normal,
                                          align: TextAlign.center)),
                                ]),
                        ),
            )
          ],
        ));
      },
    );
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
