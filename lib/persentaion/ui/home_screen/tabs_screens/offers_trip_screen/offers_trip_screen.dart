import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi/core/widgets/circle_image_widget.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/offers_trip_screen/components/item_offers_list.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/thems/them.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/container.divider.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../controller/home_cubit/cubit/home_cubit.dart';
import '../trip_summary_screen/components/container_trip_summery.dart';

class OffersTripScreen extends StatefulWidget {
  const OffersTripScreen({super.key});

  @override
  State<OffersTripScreen> createState() => _OffersTripScreenState();
}

class _OffersTripScreenState extends State<OffersTripScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(styleMap);
    mapController = controller;
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
            body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
            ),

            // list Offers
            Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 340,
                  width: double.infinity,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 3),
                      decoration: const BoxDecoration(
                          color: buttonsColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: const Texts(
                          title: Strings.selectOffer,
                          textColor: Colors.white,
                          fontSize: 13,
                          weight: FontWeight.normal,
                          align: TextAlign.center),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: 3,
                            padding: const EdgeInsets.symmetric(horizontal: 19),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    HomeCubit.get(context).changeIndex(3);
                                  },
                                  child: const ItemOffersList());
                            }))
                  ]),
                )),

            // container details trip

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                width: double.infinity,
                height: 225,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Column(children: [
                  sizedHeight(13),
                  const ContainerDivider(
                    color: Color(0xffBEBEBE),
                    height: 3,
                    width: 120,
                  ),
                  sizedHeight(17),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Texts(
                          title: Strings.tripSummary,
                          textColor: textColor,
                          fontSize: 20,
                          weight: FontWeight.normal,
                          align: TextAlign.center),
                      sizedWidth(40),
                      const Texts(
                          title: "٤٥ دقيقه",
                          textColor: Colors.grey,
                          fontSize: 15,
                          weight: FontWeight.normal,
                          align: TextAlign.center),
                    ],
                  ),
                  sizedHeight(6),
                   ContainerTripSummery(
                    onTap: () {
                      
                    },
                    title: Strings.starting,
                    value: "3482+V2, Al Mendassah 44289, Saudi Arabia",
                  ),
                  sizedHeight(6),
                   ContainerTripSummery(
                    onTap: () {
                      
                    },
                    title: Strings.arrive,
                    value: "44299, Saudi Arabia",
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                            height: 55,
                            color: buttonsColor,
                            onPress: () {
                              HomeCubit.get(context).changeIndex(2);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Texts(
                                    title: Strings.cancelTrip,
                                    textColor: Colors.white,
                                    fontSize: 14,
                                    weight: FontWeight.normal,
                                    align: TextAlign.center),
                              ],
                            )),
                      ),
                      sizedWidth(28),
                      Expanded(
                        child: ButtonWidget(
                            height: 55,
                            color: buttonsColor,
                            onPress: () {
                              HomeCubit.get(context).changeIndex(2);
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.sync,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Texts(
                                    title: Strings.updateTrip,
                                    textColor: Colors.white,
                                    fontSize: 14,
                                    weight: FontWeight.normal,
                                    align: TextAlign.center),
                              ],
                            )),
                      ),
                    ],
                  ),
                  sizedHeight(6),
                ]),
              ),
            )
          ],
        ));
      },
    );
  }
}
