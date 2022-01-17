import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/use_cases/uber_profile_upload_vehicle_data_usecase.dart';
import 'package:uber_driver_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/available_for_ride/user_req_cubit.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/driver_live_location/driver_location_cubit.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/uber_driver_map/uber_map_cubit.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/presentation/cubit/trip_history_cubit.dart';

import 'core/data_sources/remote_data_source/firebase/firebase_data_source.dart';
import 'core/data_sources/remote_data_source/firebase/firebase_data_source_impl.dart';
import 'core/internet/internet_cubit.dart';
import 'features/uber_auth_feature/data/data_sources/uber_auth_data_source.dart';
import 'features/uber_auth_feature/data/data_sources/uber_auth_data_source_impl.dart';
import 'features/uber_auth_feature/data/repositories/uber_auth_repository_impl.dart';
import 'features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';
import 'features/uber_auth_feature/domain/use_cases/uber_add_profile_image_usecase.dart';
import 'features/uber_auth_feature/domain/use_cases/uber_auth_check_user_status_usecase.dart';
import 'features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'features/uber_auth_feature/domain/use_cases/uber_auth_is_sign_in_usecase.dart';
import 'features/uber_auth_feature/domain/use_cases/uber_auth_otp_verification_usecase.dart';
import 'features/uber_auth_feature/domain/use_cases/uber_auth_phone_verification_usecase.dart';
import 'features/uber_auth_feature/domain/use_cases/uber_auth_sign_out_usecase.dart';
import 'features/uber_auth_feature/presentation/getx/auth_controller.dart';
import 'features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'features/uber_profile_feature/data/data_sources/uber_profile_data_source_impl.dart';
import 'features/uber_profile_feature/data/repositories/uber_profile_repository_impl.dart';
import 'features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';
import 'features/uber_profile_feature/domain/use_cases/uber_profile_get_driver_usecase.dart';
import 'features/uber_profile_feature/domain/use_cases/uber_profile_update_driver_usecase.dart';
import 'features/uber_trip_feature/data/repositories/driver_location_repository_impl.dart';
import 'features/uber_trip_feature/domain/repositories/driver_location_repository.dart';
import 'features/uber_trip_feature/domain/use_cases/driver_location_usecase.dart';
import 'features/uber_trip_feature/domain/use_cases/driver_update_usecase.dart';
import 'features/uber_trips_history_feature/data/repositories/trip_history_repository_impl.dart';
import 'features/uber_trips_history_feature/domain/repositories/trip_history_repository.dart';
import 'features/uber_trips_history_feature/domain/use_cases/get_trip_history_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //////////////////////////////////////////////////////////////////
  ////////////////////// Cubits ///////////////////////////////////
  //////////////////////////////////////////////////////////////////

  sl.registerFactory(
    () => UserReqCubit(
      tripHistoryUseCase: sl.call(),
      driverUpdateUseCase: sl.call(),
      getUserUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => TripHistoryCubit(
      tripHistoryUseCase: sl.call(),
      getUserUidUseCase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => InternetCubit(connectivity: sl.call()),
  );
  sl.registerFactory(
    () => UberMapCubit(),
  );

  sl.registerFactory(
    () => DriverLocationCubit(
        driverLocationUseCase: sl.call(), getUserUidUseCase: sl.call()),
  );

  //////////////////////////////////////////////////////////////////
  ////////////////////// GetX Controllers //////////////////////////
  //////////////////////////////////////////////////////////////////

  sl.registerFactory<UberAuthController>(() => UberAuthController(
      uberAuthIsSignInUseCase: sl.call(),
      uberAuthPhoneVerificationUseCase: sl.call(),
      uberAuthOtpVerificationUseCase: sl.call(),
      uberAuthCheckUserStatusUseCase: sl.call(),
      uberAuthGetUserUidUseCase: sl.call(),
      uberProfileUpdateDriverUsecase: sl.call(),
      uberAddProfileImgUseCase: sl.call(),
      uberUploadDriverVehicleDataUseCase: sl.call()));

  sl.registerFactory<UberProfileController>(() => UberProfileController(
      uberProfileUpdateDriverUsecase: sl.call(),
      uberAuthSignOutUseCase: sl.call(),
      uberAddProfileImgUseCase: sl.call(),
      uberAuthGetUserUidUseCase: sl.call(),
      uberProfileGetRiderProfileUsecase: sl.call()));

  //////////////////////////////////////////////////////////////////
  ////////////////////// Use Cases /////////////////////////////////
  //////////////////////////////////////////////////////////////////

  // Location
  sl.registerLazySingleton(() => DriverUpdateUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DriverLocationUseCase(repository: sl.call()));

  // Trip History
  sl.registerLazySingleton(() => TripHistoryUseCase(repository: sl.call()));

  // Profile
  sl.registerLazySingleton<UberProfileGetDriverProfileUsecase>(() =>
      UberProfileGetDriverProfileUsecase(uberProfileRepository: sl.call()));

  sl.registerLazySingleton<UberUploadDriverVehicleDataUseCase>(() =>
      UberUploadDriverVehicleDataUseCase(uberProfileRepository: sl.call()));

  sl.registerLazySingleton<UberProfileUpdateDriverUsecase>(
      () => UberProfileUpdateDriverUsecase(uberProfileRepository: sl.call()));

  sl.registerLazySingleton<UberAddProfileImgUseCase>(
      () => UberAddProfileImgUseCase(uberAuthRepository: sl.call()));

  // authentication
  sl.registerLazySingleton<UberAuthIsSignInUseCase>(
      () => UberAuthIsSignInUseCase(uberAuthRepository: sl.call()));
  sl.registerLazySingleton<UberAuthPhoneVerificationUseCase>(
      () => UberAuthPhoneVerificationUseCase(uberAuthRepository: sl.call()));
  sl.registerLazySingleton<UberAuthOtpVerificationUseCase>(
      () => UberAuthOtpVerificationUseCase(uberAuthRepository: sl.call()));
  sl.registerLazySingleton<UberAuthGetUserUidUseCase>(
      () => UberAuthGetUserUidUseCase(uberAuthRepository: sl.call()));
  sl.registerLazySingleton<UberAuthCheckUserStatusUseCase>(
      () => UberAuthCheckUserStatusUseCase(uberAuthRepository: sl.call()));
  sl.registerLazySingleton<UberAuthSignOutUseCase>(
      () => UberAuthSignOutUseCase(uberAuthRepository: sl.call()));

  //////////////////////////////////////////////////////////////////
  ////////////////////// Repositories //////////////////////////////
  //////////////////////////////////////////////////////////////////

  sl.registerLazySingleton<UberAuthRepository>(
      () => UberAuthRepositoryImpl(uberAuthDataSource: sl.call()));

  sl.registerLazySingleton<TripHistoryRepository>(
    () => TripHistoryRepositoryImpl(firebaseNearByMeDataSource: sl.call()),
  );
  sl.registerLazySingleton<DriverLocationRepository>(
    () => DriverLocationRepositoryImpl(firebaseNearByMeDataSource: sl.call()),
  );

  sl.registerLazySingleton<UberProfileRepository>(
      () => UberProfileRepositoryImpl(uberProfileDataSource: sl.call()));

  //////////////////////////////////////////////////////////////////
  ////////////////////// Data Sources //////////////////////////////
  //////////////////////////////////////////////////////////////////

  sl.registerLazySingleton<FirebaseDataSource>(
    () => FirebaseDataSourceImpl(),
  );
  sl.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  sl.registerLazySingleton<UberAuthDataSource>(() => UberAuthDataSourceImpl(
      firestore: sl.call(), auth: sl.call(), firebaseStorage: sl.call()));

  sl.registerLazySingleton<UberProfileDataSource>(
      () => UberProfileDataSourceImpl(firestore: sl.call(), auth: sl.call()));

  //////////////////////////////////////////////////////////////////
  //////////////// External Firebase Dependency ////////////////////
  //////////////////////////////////////////////////////////////////

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => firebaseStorage);
}
