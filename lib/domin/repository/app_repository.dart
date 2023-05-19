import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';


abstract class BaseAppRepository{
  Future<Either<Failure, String>> uploadImage({file});


}