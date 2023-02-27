import 'package:dartz/dartz.dart';

import '../../core/failur/failure.dart';
import '../entities/response_login.dart';
import '../entities/response_signup.dart';
import '../entities/user.dart';

abstract class BaseAuthRepository{
  Future<Either<Failure, ResponseLogin>> checkUserName({userName});

  Future<Either<Failure, ResponseSignUp>> signUp({user});

  Future<Either<Failure, User>> login({userName,deviceToken,code});
}