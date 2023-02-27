

import 'package:dartz/dartz.dart';
import 'package:taxi/data/models/rsponse_home.dart';
import 'package:taxi/domin/entities/car_type.dart';
import 'package:taxi/domin/entities/trip.dart';

import '../../core/failur/failure.dart';

abstract class BaseTripRepository{
  Future<Either<Failure, List<CartType>>> getCarTypes();

 Future<Either<Failure, Trip>> addTrip(Trip trip);

  Future<Either<Failure, ResponseHome>> homeTrip({userId});
}