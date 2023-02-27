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
import '../../../../../core/widgets/texts.dart';
import '../../../../controller/home_cubit/cubit/home_cubit.dart';
import '../start_trip_screen/components/container_input_address.dart';

class RunningTripScreen extends StatefulWidget {
  const RunningTripScreen({super.key});

  @override
  State<RunningTripScreen> createState() => _RunningTripScreenState();
}

class _RunningTripScreenState extends State<RunningTripScreen> {
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
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                width: double.infinity,
               
                
                child:  ButtonWidget(
                      height: 55,
                      color: buttonsColor,
                      onPress: () {
                        
                      },
                      child: const Texts(
                          title: Strings.completed,
                          textColor: Colors.white,
                          fontSize: 14,
                          weight: FontWeight.normal,
                          align: TextAlign.center)),  ),
            )
          ],
        ));
      },
    );
  }
}
