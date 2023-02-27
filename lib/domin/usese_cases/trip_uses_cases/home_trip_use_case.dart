import 'package:dartz/dartz.dart';
import 'package:taxi/data/models/rsponse_home.dart';

import '../../../core/failur/failure.dart';
import '../../entities/trip.dart';
import '../../repository/trip_base_repository.dart';

class HomeTripUseCase{
  final BaseTripRepository repository;

  HomeTripUseCase(this.repository);

  Future<Either<Failure,ResponseHome>> execute({userId})async{

    return await repository.homeTrip(userId: userId);
  }
}