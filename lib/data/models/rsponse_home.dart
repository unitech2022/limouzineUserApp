import 'package:taxi/data/models/driver_model.dart';
import 'package:taxi/data/models/trip_model.dart';
import 'package:taxi/data/models/user_response.dart';
import 'package:taxi/domin/entities/trip.dart';

import '../../domin/entities/driver.dart';

class ResponseHome {
  final Trip? trip;
  final Driver? driver;
  final bool tripActive;
  final UserDetail? userDetail;

  ResponseHome(
      {required this.trip,
      required this.tripActive,
      this.driver,
      this.userDetail});

  factory ResponseHome.fromJson(Map<String, dynamic> json) => ResponseHome(
      trip: json['trip'] != null ? TripModel.fromJson(json['trip']) : null,
      driver:
          json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      userDetail: json['userDetail'] != null
          ? UserDetail.fromJson(json['userDetail'])
          : null,
      tripActive: json['tripActive']);
}
