import 'package:dartz/dartz.dart';
import '../../../core/failur/failure.dart';

import '../../entities/response_signup.dart';
import '../../repository/base_auth_repository.dart';

  class SignUpUseCase{
  final BaseAuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, ResponseSignUp>> execute({user})async{

    return await repository.signUp(user:user);
  }
}