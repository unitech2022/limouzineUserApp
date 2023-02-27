import 'package:dartz/dartz.dart';

import '../../../core/failur/failure.dart';
import '../../repository/app_repository.dart';

class AppUseCase{
  final BaseAppRepository repository;

  AppUseCase(this.repository);

  Future<Either<Failure, String>> execute({file})async{

    return await repository.uploadImage(file: file);
  }
}