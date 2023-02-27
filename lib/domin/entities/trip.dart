import 'package:equatable/equatable.dart';

class Trip extends Equatable {
  final int id;
  final int driverId;
  final int carId;
  final double price;
  final String userId;
  final double startPointLat;
  final double startPointLng;
  final double endPointLat;
  final double endPointLng;
  final String startAddress;
  final String endAddress;
  final String otp;
  final int status;
  final int payment;
  final String createdAt;

  Trip({
    required this.id,
    required this.driverId,
    required this.carId,
    required this.price,
    required this.userId,
    required this.startPointLat,
    required this.startPointLng,
    required this.endPointLat,
    required this.endPointLng,
    required this.startAddress,
    required this.endAddress,
    required this.otp,
    required this.status,
    required this.payment,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        carId,
        driverId,
        price,
        userId,
        startPointLat,
        startPointLng,
        endPointLat,
        endPointLng,
        endAddress,
        startAddress,
        otp,
        status,
        payment,
        createdAt
      ];
}
