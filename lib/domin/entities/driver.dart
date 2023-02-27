import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final int id;

  final String userId;

  final double lat;
  final double lng;
  final int zoneId;
  final String passport;

  final String drivingLicense;

  final String carImage;
  final int carModelId;
  final String carMakeYear;
  final int status;
  final String createdAt;

  Driver(
      {required this.id,
      required this.userId,
      required this.lat,
      required this.lng,
      required this.zoneId,
      required this.passport,
      required this.drivingLicense,
      required this.carImage,
      required this.carModelId,
      required this.carMakeYear,
      required this.status,
      required this.createdAt});

  @override
  List<Object> get props => [
        id,
        userId,
        lat,
        lng,
        zoneId,
        passport,
        drivingLicense,
        carImage,
        carModelId,
        carMakeYear,
        status,
        createdAt,
      ];
}
