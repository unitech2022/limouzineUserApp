import 'package:dartz/dartz.dart';
import 'package:taxi/domin/entities/car_type.dart';
import 'package:taxi/domin/entities/trip.dart';
import 'package:taxi/domin/repository/trip_base_repository.dart';

import '../../../core/failur/failure.dart';
import '../../entities/response_signup.dart';

class AddTripUseCase{
  final BaseTripRepository repository;

  AddTripUseCase(this.repository);

  Future<Either<Failure,Trip>> execute(Trip trip)async{

    return await repository.addTrip(trip);
  }
}