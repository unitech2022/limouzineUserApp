import 'package:dartz/dartz.dart';
import 'package:taxi/core/failur/failure.dart';
import 'package:taxi/data/data_source/remote_data_source/trip_remote_data_source.dart';
import 'package:taxi/data/models/rsponse_home.dart';
import 'package:taxi/domin/entities/car_type.dart';
import 'package:taxi/domin/entities/trip.dart';
import 'package:taxi/domin/repository/trip_base_repository.dart';

import '../../core/error/exceptions.dart';


class TripRepository extends BaseTripRepository {

  final BaseTripRemoteDataSource baseRemoteDataSource;


  TripRepository(this.baseRemoteDataSource);


  @override
  Future<Either<Failure, List<CartType>>> getCarTypes()async {

    final result = await baseRemoteDataSource.getCarTypes();

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Trip>> addTrip(Trip trip,{type}) async{
   final result = await baseRemoteDataSource.addTrip(trip,type:type);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, ResponseHome>> homeTrip({userId}) async{
    
   final result = await baseRemoteDataSource.homeTrip(userId:userId);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }


}