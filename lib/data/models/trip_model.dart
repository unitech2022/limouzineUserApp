import 'package:taxi/domin/entities/trip.dart';

class TripModel extends Trip {
  TripModel(
      {required super.id,
      required super.driverId,
      required super.carId,
      required super.price,
      required super.userId,
      required super.startPointLat,
      required super.startPointLng,
      required super.endPointLat,
      required super.endPointLng,
      required super.startAddress,
      required super.endAddress,
      required super.otp,
      required super.status,
      required super.payment,
      required super.createdAt});

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
      id: json['id'],
      driverId: json['driverId'],
      carId: json['carId'],
      price: json['price'].toDouble(),
      userId: json['userId'],
      startPointLat: json['startPointLat'].toDouble(),
      startPointLng: json['startPointLng'].toDouble(),
      endPointLat: json['endPointLat'].toDouble(),
      endPointLng: json['endPointLng'].toDouble(),
      startAddress: json['startAddress'],
      endAddress: json['endAddress'],
      otp: json['otp'],
      status: json['status'],
      payment: json['payment'],
      createdAt: json['createdAt']);
}
