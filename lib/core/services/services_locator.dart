
import 'package:get_it/get_it.dart';
import 'package:taxi/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:taxi/data/data_source/remote_data_source/trip_remote_data_source.dart';
import 'package:taxi/data/repository/auth_repostory.dart';
import 'package:taxi/data/repository/trip_repository.dart';
import 'package:taxi/domin/repository/app_repository.dart';
import 'package:taxi/domin/usese_cases/app_use_case/app_use_case.dart';
import 'package:taxi/domin/usese_cases/trip_uses_cases/add_trip_use_case.dart';
import 'package:taxi/domin/usese_cases/trip_uses_cases/get_car_types_use_case.dart';
import 'package:taxi/domin/usese_cases/trip_uses_cases/home_trip_use_case.dart';

import 'package:taxi/persentaion/controller/app_cubit/cubit/app_cubit.dart';
import 'package:taxi/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:taxi/persentaion/controller/map_cubit%20copy/map_cubit.dart';
import 'package:taxi/persentaion/controller/notifictions_cubit/cubit/notifications_cubit.dart';
import 'package:taxi/persentaion/controller/trip_cubit/trip_cubit.dart';
import '../../data/data_source/remote_data_source/app_remote_data_source.dart';
import '../../data/repository/app_repository.dart';
import '../../domin/repository/base_auth_repository.dart';
import '../../domin/repository/trip_base_repository.dart';
import '../../domin/usese_cases/auth_uses_cases/check_user_name_usecase.dart';
import '../../domin/usese_cases/auth_uses_cases/login_usecase.dart';
import '../../domin/usese_cases/auth_uses_cases/signup_usecase.dart';
import '../../persentaion/controller/home_cubit/cubit/home_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// bloc
    sl.registerFactory(() => HomeCubit());
    sl.registerFactory(() => AppCubit());
    sl.registerFactory(() => AuthCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => TripCubit(sl(),sl(),sl()));
    sl.registerFactory(() => MapCubit());
    // sl.registerFactory(() => PlaceCubit(sl()));

    //    sl.registerFactory(() => SearchCubit(sl()));

    /// use Cases
    sl.registerLazySingleton(() => CheckUerNameUseCase(sl()));
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => AppUseCase(sl()));
    sl.registerLazySingleton(() => GetCarTypesUseCase(sl()));
   sl.registerLazySingleton(() => AddTripUseCase(sl()));
   sl.registerLazySingleton(() => HomeTripUseCase(sl()));
  sl.registerLazySingleton(() => NotificationsCubit());
    // sl.registerLazySingleton(() => AddFavoriteUseCase(sl()));
    // sl.registerLazySingleton(() => SearchCityUseCase(sl()));

    /// repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BaseAppRepository>(() => AppRepository(sl()));
    sl.registerLazySingleton<BaseTripRepository>(() => TripRepository(sl()));
    // ///data source
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());
    sl.registerLazySingleton<BaseAppRemoteDataSource>(
        () => AppRemoteDataSource());
   sl.registerLazySingleton<BaseTripRemoteDataSource>(() => TripRemoteDataSource());
  }
}
