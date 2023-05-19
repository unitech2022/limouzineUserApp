import 'package:dartz/dartz.dart';
import 'package:taxi/core/failur/failure.dart';
import '../../core/error/exceptions.dart';
import '../../domin/repository/app_repository.dart';
import '../data_source/remote_data_source/app_remote_data_source.dart';


class AppRepository extends BaseAppRepository {
  final BaseAppRemoteDataSource baseRemoteDataSource;


  AppRepository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, String>> uploadImage({file}) async{
    final result = await baseRemoteDataSource.uploadImage(file: file);

    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }



}
