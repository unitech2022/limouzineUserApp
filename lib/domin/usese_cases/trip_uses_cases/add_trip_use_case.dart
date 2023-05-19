import 'package:dartz/dartz.dart';
import 'package:taxi/domin/entities/trip.dart';
import 'package:taxi/domin/repository/trip_base_repository.dart';

import '../../../core/failur/failure.dart';


class AddTripUseCase{
  final BaseTripRepository repository;

  AddTripUseCase(this.repository);

  Future<Either<Failure,Trip>> execute(Trip trip,{type})async{

    return await repository.addTrip(trip,type:type);
  }
}