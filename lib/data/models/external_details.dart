import 'package:taxi/data/models/external_trip.dart';
import 'package:taxi/data/models/user_model.dart';

import 'driver_model.dart';

class ExternalDetails {
  ExternalTrip? trip;
  DriverModel? driver;
  ProfileDriver? profileDriver;
  bool? isBooking;

  ExternalDetails({this.trip, this.driver, this.profileDriver, this.isBooking});

  ExternalDetails.fromJson(Map<String, dynamic> json) {
    trip = json['trip'] != null ? ExternalTrip.fromJson(json['trip']) : null;
    driver =
        json['driver'] != null ?  DriverModel.fromJson(json['driver']) : null;
    profileDriver = json['profileDriver'] != null
        ?  ProfileDriver.fromJson(json['profileDriver'])
        : null;
    isBooking = json['isBooking'];
  }

 
}
class ProfileDriver {
  String? id;
  String? fullName;
  String? userName;
  String? email;

  String? role;
  String? deviceToken;
  String? status;
  String? code;

  String? points;
  String? surveysBalance;
  String? createdAt;

  ProfileDriver(
      {this.id,
      this.fullName,
      this.userName,
      this.email,
  
      this.role,
      this.deviceToken,
      this.status,
      this.code,
  
      this.points,
      this.surveysBalance,
      this.createdAt});

  ProfileDriver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['userName'];
    email = json['email'];
   
    role = json['role'];
    deviceToken = json['deviceToken'];
    status = json['status'];
    code = json['code'];
   
    points = json['points'];
    surveysBalance = json['surveysBalance'];
    createdAt = json['createdAt'];
  }


}






