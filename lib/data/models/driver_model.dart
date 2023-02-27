import 'dart:ffi';

import '../../domin/entities/driver.dart';

class DriverModel extends Driver {
  DriverModel(
      {required super.id,
      required super.userId,
      required super.lat,
      required super.lng,
      required super.zoneId,
      required super.passport,
      required super.drivingLicense,
      required super.carImage,
      required super.carModelId,
      required super.carMakeYear,
      required super.status,
      required super.createdAt});

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
      id: json["id"],
      userId: json["userId"],
      lat: json["lat"].toDouble(),
      lng: json["lng"].toDouble(),
      zoneId: json["zoneId"],
      passport: json["passport"],
      drivingLicense: json["drivingLicense"],
      carImage: json["carImage"],
      carModelId: json["carModelId"],
      carMakeYear: json["carMakeYear"],
      status: json["status"],
      createdAt: json["createdAt"]);
}
