import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi/core/utlis/enums.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/domin/entities/address_model.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../data/models/polyline_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  static MapCubit get(context) => BlocProvider.of<MapCubit>(context);

  getEndLocation(AddressModel value, {context}) async {
    print("map =====>end location " + value.lat.toString());

    emit(state.copyWith(endPoint: value));
  }

  getStartLocation(AddressModel value, {context}) async {
    print("map =====>start location " + value.lat.toString());

    emit(state.copyWith(startPoint: value));
  }



  // Polyline Points

  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();

  // addPolyLine() {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       color: textColor,
  //       width: 4,
  //       points: polylineCoordinates);
  //   Map<PolylineId, Polyline> polylines = {};
  //   polylines[id] = polyline;
  //   print("polyline" +polylines.values.first.toString());
  //   emit(state.copyWith(polyines: polylines));
  // }

  // getPolyline(LatLng origan, LatLng dest) async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       ApiConstants.googleKey,
  //       PointLatLng(origan.latitude, origan.longitude),
  //       PointLatLng(dest.latitude, dest.longitude),
  //       travelMode: TravelMode.driving,
  //       wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   }
  //   addPolyLine();
  // }

 Set<Polyline> polylinePoints = {};
PolylineResponse polylineResponse = PolylineResponse();
  void drawPolyline(LatLng origan, LatLng dest) async {
    var response = await http.post(Uri.parse("https://maps.googleapis.com/maps/api/directions/json?key=" +
        ApiConstants.googleKey +
        "&units=metric&origin=" +
        origan.latitude.toString() +
        "," +
        origan.longitude.toString()+
        "&destination=" +
        dest.latitude.toString() +
        "," +
        dest.longitude.toString() +
        "&mode=driving"));

    print(response.body);

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));

    // totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    // totalTime = polylineResponse.routes![0].legs![0].duration!.text!;

    for (int i = 0; i < polylineResponse.routes![0].legs![0].steps!.length; i++) {
      polylinePoints.add(Polyline(polylineId: PolylineId(polylineResponse.routes![0].legs![0].steps![i].polyline!.points!), points: [
        LatLng(
            polylineResponse.routes![0].legs![0].steps![i].startLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].startLocation!.lng!),
        LatLng(polylineResponse.routes![0].legs![0].steps![i].endLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].endLocation!.lng!),
      ],width: 3,color: Colors.red));
    }

    emit(state.copyWith(polyines: polylinePoints));
  }
}



