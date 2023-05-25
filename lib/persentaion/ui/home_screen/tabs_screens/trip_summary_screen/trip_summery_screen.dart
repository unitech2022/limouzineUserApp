import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/thems/them.dart';
import '../../../../../core/utlis/strings.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/container.divider.dart';
import '../../../../../core/widgets/texts.dart';
import '../../../../controller/home_cubit/cubit/home_cubit.dart';
import 'components/container_trip_summery.dart';

class TripSummeryScreen extends StatefulWidget {
  const TripSummeryScreen({super.key});

  @override
  State<TripSummeryScreen> createState() => _TripSummeryScreenState();
}

class _TripSummeryScreenState extends State<TripSummeryScreen> {
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

            // container select addresses trip

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Texts(
                          title: Strings.tripSummary,
                          textColor: textColor,
                          fontSize: 20,
                          weight: FontWeight.normal,
                          align: TextAlign.center),
                      Texts(
                          title: "٤٥ دقيقه",
                          textColor: Colors.grey,
                          fontSize: 15,
                          weight: FontWeight.normal,
                          align: TextAlign.center),
                      Texts(
                          title: "٢٥٠. ر.س",
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
                  ButtonWidget(
                      height: 55,
                      color: buttonsColor,
                      onPress: () {
                        HomeCubit.get(context).changeIndex(2);
                      },
                      child: const Texts(
                          title: Strings.searchAboutTrip,
                          textColor: Colors.white,
                          fontSize: 14,
                          weight: FontWeight.normal,
                          align: TextAlign.center)),
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
