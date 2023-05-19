import 'package:dartz/dartz.dart';
import 'package:taxi/domin/entities/car_type.dart';
import 'package:taxi/domin/repository/trip_base_repository.dart';

import '../../../core/failur/failure.dart';


class GetCarTypesUseCase{
  final BaseTripRepository repository;

  GetCarTypesUseCase(this.repository);

  Future<Either<Failure, List<CartType>>> execute()async{

    return await repository.getCarTypes();
  }
}