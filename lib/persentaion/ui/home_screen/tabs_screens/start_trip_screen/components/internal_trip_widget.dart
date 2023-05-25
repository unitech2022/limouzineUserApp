import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../../../core/helpers/functions.dart';
import '../../../../../../core/helpers/helper_functions.dart';
import '../../../../../../core/styles/colors.dart';
import '../../../../../../core/utlis/api_constatns.dart';
import '../../../../../../core/utlis/app_model.dart';
import '../../../../../../core/utlis/data.dart';
import '../../../../../../core/utlis/enums.dart';
import '../../../../../../core/utlis/strings.dart';
import '../../../../../../core/widgets/button_widget.dart';
import '../../../../../../core/widgets/container.divider.dart';
import '../../../../../../core/widgets/texts.dart';
import '../../../../../../data/models/address_model.dart';
import '../../../../../../domin/entities/address_model.dart';

import '../../../../../../domin/entities/trip.dart';
import '../../../../../controller/map_cubit copy/map_cubit.dart';
import '../../../../../controller/trip_cubit/trip_cubit.dart';
import '../../../../login_screen/login_screen.dart';
import '../../../map_screen.dart';
import '../../trip_summary_screen/components/container_trip_summery.dart';

import 'container_input_address.dart';
import 'item_saved_addresses.dart';
import 'item_trip_type.dart';
import 'list_car_type.dart';

class InternalTripWidget extends StatefulWidget {
  final TripState state;
  InternalTripWidget(this.state);

  @override
  State<InternalTripWidget> createState() => _InternalTripWidgetState();
}

class _InternalTripWidgetState extends State<InternalTripWidget> {
  int carTypeId = 0;

  final _controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: widget.state.homeState == RequestState.loading
          ? LoadingWidget(height: 380, color: buttonsColor)
          : widget.state.responseHome!.tripActive
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // width: double.infinity,
                  // height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      sizedHeight(13),
                      const ContainerDivider(
                        color: Color(0xffBEBEBE),
                        height: 3,
                        width: 120,
                      ),
                      sizedHeight(13),

                      // show trip details
                      widget.state.responseHome!.trip!.driverId != 0 &&
                              widget.state.responseHome!.trip!.status != 0
                          ? Column(
                              children: [
                                Texts(
                                    title: widget.state.responseHome!.trip!
                                                .status ==
                                            2
                                        ? Strings.ridWiyh +
                                            "  " +
                                            widget.state.responseHome!
                                                .driverDetail!.fullName!
                                        : statuesTrip[widget
                                            .state.responseHome!.trip!.status],
                                    textColor: Colors.black,
                                    fontSize: 16,
                                    weight: FontWeight.bold,
                                    align: TextAlign.center),
                                sizedHeight(13),

                                // details driver
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: CachedNetworkImage(
                                        imageUrl: ApiConstants.imageUrl(widget
                                            .state
                                            .responseHome!
                                            .driverDetail!
                                            .profileImage),
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    sizedWidth(20),
                                    Expanded(
                                      child: Texts(
                                          title: widget.state.responseHome!
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
                                sizedHeight(18),
                                // price
                                Row(
                                  children: [
                                    Texts(
                                        title: Strings.price + " : ",
                                        textColor: Colors.black,
                                        fontSize: 14,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start),
                                    sizedWidth(10),
                                    Texts(
                                        title: widget
                                            .state.responseHome!.trip!.price
                                            .toString(),
                                        textColor: Colors.black.withOpacity(.5),
                                        fontSize: 14,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start)
                                  ],
                                ),

                                sizedHeight(5),
                                // time
                                Row(
                                  children: [
                                    Texts(
                                        title: Strings.theExpectedTime + " : ",
                                        textColor: Colors.black,
                                        fontSize: 14,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start),
                                    sizedWidth(10),
                                    Texts(
                                        title: "1:00 د",
                                        textColor: Colors.black.withOpacity(.5),
                                        fontSize: 14,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start)
                                  ],
                                ),

                                // date
                                sizedHeight(5),
                                Row(
                                  children: [
                                    Texts(
                                        title: Strings.date + " : ",
                                        textColor: Colors.black,
                                        fontSize: 14,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start),
                                    sizedWidth(10),
                                    Texts(
                                        title: widget
                                            .state.responseHome!.trip!.createdAt
                                            .split("T")[0],
                                        textColor: Colors.black.withOpacity(.5),
                                        fontSize: 14,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start)
                                  ],
                                ),

                                sizedHeight(15),
                                // starting point
                                ContainerTripSummery(
                                  onTap: () {
                                    openGoogleMapLocation(
                                      lat: widget.state.responseHome!.trip!
                                          .startPointLat,
                                      lng: widget.state.responseHome!.trip!
                                          .startPointLng,
                                    );
                                  },
                                  title: Strings.starting.tr(),
                                  value: widget
                                      .state.responseHome!.trip!.startAddress,
                                ),
                                sizedHeight(6),
                                // end point
                                ContainerTripSummery(
                                  onTap: () {
                                    openGoogleMapLocation(
                                      lat: widget.state.responseHome!.trip!
                                          .startPointLat,
                                      lng: widget.state.responseHome!.trip!
                                          .endPointLng,
                                    );
                                  },
                                  title: Strings.arrive.tr(),
                                  value: widget
                                      .state.responseHome!.trip!.endAddress,
                                ),
                                sizedHeight(40),
                                widget.state.responseHome!.trip!.status < 3 ||
                                        widget.state.responseHome!.trip!
                                                .status ==
                                            5
                                    ? widget.state.changeStatusTrip ==
                                            RequestState.loading
                                        ? LoadingWidget(
                                            height: 55, color: homeColor)
                                        : ButtonWidget(
                                            height: 55,
                                            color: buttonsColor,
                                            onPress: () {
                                              print(widget.state.statues
                                                      .toString() +
                                                  "ojnbj");

                                              if (widget.state.responseHome!
                                                      .trip!.status ==
                                                  5) {
                                                rateDriver(context);
                                              } else {
                                                TripCubit.get(context)
                                                    .changeStatusTrip(
                                                        tripId:
                                                            widget
                                                                .state
                                                                .responseHome!
                                                                .trip!
                                                                .id,
                                                        status: widget
                                                                .state
                                                                .responseHome!
                                                                .trip!
                                                                .status +
                                                            1,
                                                        userId: widget
                                                            .state
                                                            .responseHome!
                                                            .driver!
                                                            .userId);
                                              }
                                            },
                                            child: Texts(
                                                title: getStatusText(widget
                                                    .state
                                                    .responseHome!
                                                    .trip!
                                                    .status),
                                                textColor: Colors.white,
                                                fontSize: 14,
                                                weight: FontWeight.normal,
                                                align: TextAlign.center))
                                    : SizedBox(),
                                sizedHeight(6),
                              ],
                            )

                          // todo :trip waiting
                          : SizedBox(
                              child: Column(
                              children: [
                                sizedHeight(40),
                                Texts(
                                    title: widget.state.timerTrip == 100
                                        ? Strings.thereNotDriver.tr()
                                        : Strings.searchTodriver.tr(),
                                    textColor: Colors.black,
                                    fontSize: 14,
                                    weight: FontWeight.normal,
                                    align: TextAlign.center),
                                sizedHeight(40),
                                LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  barRadius: Radius.circular(30),
                                  width: 300,
                                  lineHeight: 8,
                                  backgroundColor: Colors.grey,
                                  progressColor: homeColor,
                                  percent: double.parse(
                                          "${widget.state.timerTrip}") /
                                      100,
                                ),
                                sizedHeight(100),
                                widget.state.changeStatusTrip ==
                                        RequestState.loading
                                    ? LoadingWidget(
                                        height: 55, color: homeColor)
                                    : ButtonWidget(
                                        height: 55,
                                        color: buttonsColor,
                                        onPress: () {
                                          print(
                                              widget.state.statues.toString() +
                                                  "ojnbj");

                                          if (TripCubit.get(context)
                                              .timer!
                                              .isActive) {
                                            TripCubit.get(context)
                                                .cancelTimer();
                                          }
                                          TripCubit.get(context)
                                              .changeStatusTrip(
                                                  tripId:
                                                      widget.state.responseHome!
                                                          .trip!.id,
                                                  status: 7,
                                                  isState: 0,
                                                  userId: widget
                                                              .state
                                                              .responseHome!
                                                              .trip!
                                                              .driverId ==
                                                          0
                                                      ? currentUser.id!
                                                      : widget
                                                          .state
                                                          .responseHome!
                                                          .driver!
                                                          .userId);
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

              // TODO : no trip active
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
                  child: widget.state.statues == 1
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
                                    title: "اختار نوع السيارة".tr(),
                                    textColor: Colors.black,
                                    fontSize: 15,
                                    weight: FontWeight.normal,
                                    align: TextAlign.start),
                              ],
                            ),
                            sizedHeight(0),
                            Expanded(
                              child:
                                  ListCarTypes(widget.state.carTypes, (typeId) {
                                carTypeId = typeId;
                              }),
                            ),
                            widget.state.addTripState == RequestState.loading
                                ? LoadingWidget(
                                    color: buttonsColor,
                                    height: 55,
                                  )
                                : ButtonWidget(
                                    height: 55,
                                    color: buttonsColor,
                                    onPress: () {
                                      if (carTypeId != 0) {
                                        Trip trip = Trip(
                                            carId: carTypeId,
                                            startPointLat:
                                                widget.state.startPoint!.lat,
                                            startPointLng:
                                                widget.state.startPoint!.lng,
                                            endPointLat:
                                                widget.state.endPoint!.lat,
                                            endPointLng:
                                                widget.state.endPoint!.lng,
                                            startAddress:
                                                widget.state.startPoint!.label,
                                            endAddress:
                                                widget.state.endPoint!.label,
                                            otp: "000",
                                            status: 0,
                                            payment: 0,
                                            price: 30,
                                            createdAt: '',
                                            driverId: 0,
                                            id: 0,
                                            userId: currentUser.id!);

                                        TripCubit.get(context).addTrip(trip,
                                            type: widget
                                                .state.currentIndexTypeTrip);
                                      } else {
                                        showTopMessage(
                                            context: context,
                                            customBar: CustomSnackBar.error(
                                                backgroundColor: buttonsColor,
                                                message:
                                                    Strings.selsctTypeCar.tr(),
                                                textStyle: TextStyle(
                                                    fontFamily: "font",
                                                    fontSize: 16,
                                                    color: Colors.white)));
                                      }

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
                                          currentIndex: widget
                                              .state.currentIndexTypeTrip));
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
                                      value: widget
                                                  .state.currentIndexTypeTrip ==
                                              0
                                          ? widget.state.startPoint != null
                                              ? widget.state.startPoint!.label
                                              : Strings.whenStarting.tr()
                                          : widget.state.startCity != null
                                              ? AppModel.lang=="ar"?widget.state.startCity!.name!:widget.state.startCity!.name_eng!
                                              : Strings.whenStarting.tr(),
                                      addAddressWidget: const SizedBox(),
                                      onTap: () {
                                        if (widget.state.currentIndexTypeTrip ==
                                            0) {
                                          Navigator.push(
                                            context,
                                            // Create the SelectionScreen in the next step.
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectAddressScreen(
                                                        0,
                                                        widget
                                                            .state
                                                            .responseHome!
                                                            .addresses)),
                                          ).then((value) {
                                            TripCubit.get(context)
                                                .getStartLocation(
                                                    value as AddressModel);
                                            MapCubit.get(context)
                                                .getStartLocation(value);
                                          });
                                        } else {
                                          TripCubit.get(context).filteredList =
                                              cities;
                                          showCitySheet(type: "start");
                                        }
                                      },
                                    )),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ContainerInputAddress(
                                      title: Strings.end.tr(),
                                      value:
                                          widget.state.currentIndexTypeTrip == 0
                                              ? widget.state.endPoint != null
                                                  ? widget.state.endPoint!.label
                                                  : Strings.whenEnd.tr()
                                              : widget.state.endCity != null
                                                  ?AppModel.lang=="ar"? widget.state.endCity!.name!:widget.state.endCity!.name_eng!
                                                  : Strings.whenStarting.tr(),
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
                                        if (widget.state.currentIndexTypeTrip ==
                                            0) {
                                          Navigator.push(
                                            context,
                                            // Create the SelectionScreen in the next step.
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectAddressScreen(
                                                        0,
                                                        widget
                                                            .state
                                                            .responseHome!
                                                            .addresses)),
                                          ).then((value) {
                                            print(value.label +
                                                "========> label");
                                            TripCubit.get(context)
                                                .getEndLocation(
                                                    value as AddressModel);
                                          });
                                        } else {
                                          TripCubit.get(context).filteredList =
                                              cities;
                                          showCitySheet(type: "end");
                                        }
                                      },
                                    )),

                                // Align(
                                //   alignment: Alignment.center,
                                //   child: GestureDetector(
                                //     onTap: () {},
                                //     child: Container(
                                //         padding: const EdgeInsets.all(8),
                                //         height: 36,
                                //         width: 36,
                                //         decoration: const BoxDecoration(
                                //             color: Color(0xffA5A5A5),
                                //             shape: BoxShape.circle),
                                //         child: SvgPicture.asset(
                                //           "assets/icons/sync_alt.svg",
                                //           width: 20,
                                //           height: 18,
                                //         )),
                                //   ),
                                // )
                              ])),

                          sizedHeight(13),
                          // list saved Addresses
                      widget.state.currentIndexTypeTrip==0?
                          widget.state.responseHome!.addresses.isEmpty
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      // Create the SelectionScreen in the next step.
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectAddressScreen(
                                                  1,
                                                  widget.state.responseHome!
                                                      .addresses)),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 36,
                                        width: 36,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Texts(
                                          title: Strings.addNewAddress.tr(),
                                          textColor: Colors.black,
                                          fontSize: 16,
                                          weight: FontWeight.bold,
                                          align: TextAlign.start),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 63,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.state.responseHome!
                                              .addresses.length +
                                          1,
                                      itemBuilder: (context, index) {
                                        print(index.toString() + "-=======>");
                                        if (index ==
                                            widget.state.responseHome!.addresses
                                                .length) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                // Create the SelectionScreen in the next step.
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SelectAddressScreen(
                                                            1, [])),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 36,
                                                  width: 36,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                Texts(
                                                    title: Strings.addNewAddress
                                                        .tr(),
                                                    textColor: Colors.black,
                                                    fontSize: 14,
                                                    weight: FontWeight.bold,
                                                    align: TextAlign.start),
                                              ],
                                            ),
                                          );
                                        }
                                        AddressResponse address = widget.state
                                            .responseHome!.addresses[index];
                                        return GestureDetector(
                                          onTap: () {
                                            AddressModel addressModel =
                                                AddressModel(
                                                    label: address.label!,
                                                    lat: address.lat!,
                                                    lng: address.lang!);
                                            TripCubit.get(context)
                                                .getEndLocation(addressModel,
                                                    context: context);
                                            MapCubit.get(context)
                                                .getEndLocation(addressModel,
                                                    context: context);
                                          },
                                          child: ItemSavedAddresses(
                                            address: address,
                                          ),
                                        );
                                      }),
                                ):SizedBox(),
                          const Spacer()
                          // button search
                          ,
                      ( widget.state.currentIndexTypeTrip==1 && widget.state.addTripState==RequestState.loading)?
                      
                      LoadingWidget(height: 55, color: buttonsColor)
                      
                      :   ButtonWidget(
                              height: 55,
                              color: buttonsColor,
                              onPress: () {
                                if (widget.state.currentIndexTypeTrip == 0) {
                                  if (validateAddressSelector(widget.state)) {
                                    TripCubit.get(context)
                                        .changeStatusScreen(1);
                                  }
                                } else {
                                  if (validateGroup(widget.state)) {
                                    TripCubit.get(context).addGroup(
                                        startCity: widget.state.startCity!.name!,
                                        endCity: widget.state.endCity!.name!,context: context);
                                  }
                                }

                                // if (state.startPoint != null) {
                                //   Navigator.push(
                                //     context,
                                //     // Create the SelectionScreen in the next step.
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SelectAddressScreen(0)),
                                //   ).then((value) {
                                //     TripCubit.get(context).getEndLocation(
                                //         value as AddressModel,
                                //         context: context);
                                //     MapCubit.get(context).getEndLocation(value);
                                //   });
                                // } else {
                                //   showToast(message: "اختار البداية");
                                // }
                              },
                              child: Texts(
                                  title: widget.state.currentIndexTypeTrip == 0
                                      ? Strings.searchAboutTrip.tr()
                                      : Strings.starTrip.tr(),
                                  textColor: Colors.white,
                                  fontSize: 14,
                                  weight: FontWeight.normal,
                                  align: TextAlign.center)),
                        ]),
                ),
    );
  }

//TODO:  RATING
  Future<dynamic> rateDriver(BuildContext context) {
    double stars = 3;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BlocBuilder<TripCubit, TripState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: double.infinity,
                height: heightScreen(context) / 1.5,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // sizedHeight(15),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              pop(context);
                            },
                            icon: Icon(Icons.close, color: buttonsColor))
                      ],
                    ),

                    Texts(
                        title: "اترك تقييما",
                        textColor: Colors.black,
                        fontSize: 30,
                        weight: FontWeight.bold,
                        align: TextAlign.start),
                    sizedHeight(15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: ApiConstants.imageUrl(widget
                            .state.responseHome!.driverDetail!.profileImage),
                        width: 100,
                        height: 100,
                      ),
                    ),
                    sizedHeight(10),
                    Texts(
                        title:
                            widget.state.responseHome!.driverDetail!.fullName! +
                                "  ",
                        textColor: textColor,
                        fontSize: 16,
                        weight: FontWeight.bold,
                        align: TextAlign.start),

                    sizedHeight(10),
                    SizedBox(
                      child: RatingBar.builder(
                        initialRating: stars,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: buttonsColor,
                        ),
                        onRatingUpdate: (rating) {
                          stars = rating;
                          print(stars);
                        },
                      ),
                    ),
                    sizedHeight(10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38, width: .8)),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: Strings.enterComments,
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: InputBorder.none),
                      ),
                    ),
                    Spacer(),

                    widget.state.addRateState == RequestState.loading
                        ? LoadingWidget(height: 55, color: homeColor)
                        : ButtonWidget(
                            height: 55,
                            color: buttonsColor,
                            onPress: () {
                              TripCubit.get(context).addRateDriver(
                                  stare: stars,
                                  comment: _controller.text,
                                  tripId: widget.state.responseHome!.trip!.id,
                                  driverId:
                                      widget.state.responseHome!.driver!.id,
                                  status:
                                      widget.state.responseHome!.trip!.status,
                                  driverUserId:
                                      widget.state.responseHome!.driver!.userId,
                                  context: context);
                            },
                            child: Texts(
                                title: Strings.send,
                                textColor: Colors.white,
                                fontSize: 14,
                                weight: FontWeight.normal,
                                align: TextAlign.center))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String getStatusText(int status) {
    if (status == 2) {
      return Strings.searchAboutTrip;
    } else if (status == 5) {
      return "تأكيد االرحلة ";
    } else {
      return Strings.cancelTrip.tr();
    }
  }

  bool validateAddressSelector(TripState state) {
    if (state.startPoint == null) {
      showToast(message: "اختار البداية".tr());
      return false;
    } else if (state.endPoint == null) {
      showToast(message: "اختار الوجهة".tr());
      return false;
    } else {
      return true;
    }
  }

// SHOW CITIES
  showCitySheet({type}) => showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocBuilder<TripCubit,TripState>(
            builder: ( context,  stat) {
          return Container(
              // height: 300,

              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (ctx, i) => i == 0
                    ? Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                            Expanded(
                              child: TextFormField(
                                onChanged: (v) {

                                   TripCubit.get(context).searchCity(v.toString());

                                },
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                decoration:  InputDecoration(
                                    isDense: true,
                                    //to reduce the size of icon, use if you want. I used, because my custom font icon is big
                                    labelText: Strings.searchWithCityName.tr(),
                                    contentPadding: EdgeInsets.only(left: 0),
                                    //to make the base line of icon & text in same
                                    labelStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(Icons.search)),
                              ),
                            ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          pop(context);
                          TripCubit.get(context).setCityPoint(
                              TripCubit.get(context).filteredList[i - 1], type);
                        },
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Icon(Icons.point)
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                width: 10,
                              ),

                              Text(
                                AppModel.lang=="ar"?TripCubit.get(context)
                                    .filteredList[i - 1]
                                    .name!:TripCubit.get(context)
                                    .filteredList[i - 1]
                                    .name_eng!,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  height: 1.92,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ),
                itemCount: TripCubit.get(context).filteredList.length + 1,
              ));
        });
      });

  bool validateGroup(TripState state) {
    if (state.startCity == null) {
      showToast(message: "اختار البداية".tr());
      return false;
    } else if (state.endCity == null) {
      showToast(message: "اختار الوجهة".tr());
      return false;
    } else {
      return true;
    }
  }
}
