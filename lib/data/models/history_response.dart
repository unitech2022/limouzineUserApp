import 'package:taxi/data/models/car_type_model.dart';
import 'package:taxi/data/models/driver_model.dart';
import 'package:taxi/data/models/trip_model.dart';
import 'package:taxi/data/models/user_response.dart';


class ResponseHistory {
  List<HistoryModel>? canceledTrips;
  List<HistoryModel>? doneTrips;

  ResponseHistory({this.canceledTrips, this.doneTrips});

  ResponseHistory.fromJson(Map<String, dynamic> json) {
    if (json['canceledTrips'] != null) {
      canceledTrips = [];
      json['canceledTrips'].forEach((v) {
        canceledTrips!.add( HistoryModel.fromJson(v));
      });
    }
    if (json['doneTrips'] != null) {
      doneTrips = [];
      json['doneTrips'].forEach((v) {
        doneTrips!.add( HistoryModel.fromJson(v));
      });
    }
  }


}

class HistoryModel {
  DriverModel? driver;
  TripModel? trip;
  UserDetail? userDetailDiver;
  CarTypeModel? carType;

  HistoryModel({this.driver, this.trip, this.userDetailDiver, this.carType});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    driver = json['driver'] != null ? new DriverModel.fromJson( json['driver']) : null;
    trip = json['trip'] != null ? new TripModel.fromJson(json['trip']) : null;
    userDetailDiver =  json['userDetailDiver'] != null ? new UserDetail.fromJson(json['userDetailDiver']) : null;
    carType =json['carType'] != null ? new CarTypeModel.fromJson(json['carType']) : null ;
  }


}