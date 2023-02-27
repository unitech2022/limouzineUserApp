import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../entities/response_login.dart';

abstract class BaseAppRepository{
  Future<Either<Failure, String>> uploadImage({file});


}