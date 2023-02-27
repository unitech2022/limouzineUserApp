import 'package:dartz/dartz.dart';

import '../../../core/failur/failure.dart';
import '../../entities/response_login.dart';
import '../../repository/base_auth_repository.dart';

class CheckUerNameUseCase{
  final BaseAuthRepository repository;

  CheckUerNameUseCase(this.repository);

  Future<Either<Failure, ResponseLogin>> execute({userName})async{

    return await repository.checkUserName(userName: userName);
  }
}