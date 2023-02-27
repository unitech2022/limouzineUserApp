import 'package:dartz/dartz.dart';
import 'package:taxi/core/failur/failure.dart';
import 'package:taxi/domin/entities/response_login.dart';
import 'package:taxi/domin/entities/user.dart';
import '../../core/error/exceptions.dart';
import '../../domin/entities/response_signup.dart';
import '../../domin/repository/base_auth_repository.dart';
import '../data_source/remote_data_source/auth_remote_data_source.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseRemoteDataSource;


  AuthRepository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, ResponseLogin>> checkUserName({userName}) async{
    final result = await baseRemoteDataSource.checkUserName(userName: userName);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, User>> login({userName, deviceToken, code}) async{
    final result = await baseRemoteDataSource.login(userName: userName);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, ResponseSignUp>> signUp({user}) async{
    final result = await baseRemoteDataSource.signUp(user: user);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

}
