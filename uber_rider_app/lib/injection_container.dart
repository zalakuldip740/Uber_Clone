import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:uber_rider_app/features/uber_home_page_map_feature/data/data_sources/user_current_location_data_source.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/data/data_sources/user_current_location_data_source_impl.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/data/repositories/user_current_location_repository_impl.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/domain/repositories/user_current_location_repository.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/domain/use_cases/get_user_current_location_usecase.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/presentation/cubit/uber_current_location_cubit.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/data_sources/uber_map_data_source.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/data_sources/uber_map_data_source_impl.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/repositories/uber_map_repository_impl.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/repositories/uber_map_repository.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/cancel_trip_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/uber_map_direction_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/uber_map_get_drivers_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/uber_map_prediction_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/vehicle_details_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/getx/uber_map_controller.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source_impl.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/repositories/uber_profile_repository_impl.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_profile_get_rider_usecase.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';

import 'features/uber_map_feature/domain/use_cases/generate_trip_usecase.dart';
import 'features/uber_map_feature/domain/use_cases/get_rental_charges_usecase.dart';
import 'features/uber_map_feature/presentation/getx/uber_live_tracking_controller.dart';
import 'features/uber_profile_feature/domain/use_cases/uber_profile_update_rider_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // feature:- current location
  //cubit
  // usercurrentlocationcubit
  sl.registerFactory<UberCurrentLocationCubit>(
      () => UberCurrentLocationCubit(getUserCurrentLocationUsecase: sl.call()));

  //current location Usecase

  sl.registerLazySingleton<GetUserCurrentLocationUsecase>(() =>
      GetUserCurrentLocationUsecase(userCurrentLocationRepository: sl.call()));

  // current location repository
  sl.registerLazySingleton<UserCurrentLocationRepository>(() =>
      UserCurrentLocationRepositoryImpl(
          userCurrentLocationDataSource: sl.call()));

  // current location datasource

  sl.registerLazySingleton<UserCurrentLocationDataSource>(
      () => UserCurrentLocationDataSourceImpl());

  // feature map
  // getx

  sl.registerFactory<UberMapController>(() => UberMapController(
      uberMapPredictionUsecase: sl.call(),
      uberMapDirectionUsecase: sl.call(),
      uberMapGetDriversUsecase: sl.call(),
      uberMapGetRentalChargesUseCase: sl.call(),
      uberMapGenerateTripUseCase: sl.call(),
      uberMapGetVehicleDetailsUseCase: sl.call(),
      uberCancelTripUseCase: sl.call()));
  sl.registerFactory<UberLiveTrackingController>(
      () => UberLiveTrackingController(uberMapDirectionUsecase: sl.call()));
  //usecase
  sl.registerLazySingleton<UberMapPredictionUsecase>(
      () => UberMapPredictionUsecase(uberMapRepository: sl.call()));
  sl.registerLazySingleton<UberMapDirectionUsecase>(
      () => UberMapDirectionUsecase(uberMapRepository: sl.call()));
  sl.registerLazySingleton<UberMapGetDriversUsecase>(
      () => UberMapGetDriversUsecase(uberMapRepository: sl.call()));
  sl.registerLazySingleton<UberMapGetRentalChargesUseCase>(
      () => UberMapGetRentalChargesUseCase(uberMapRepository: sl.call()));
  sl.registerLazySingleton<UberMapGenerateTripUseCase>(
      () => UberMapGenerateTripUseCase(uberMapRepository: sl.call()));
  sl.registerLazySingleton<UberMapGetVehicleDetailsUseCase>(
      () => UberMapGetVehicleDetailsUseCase(uberMapRepository: sl.call()));

  sl.registerLazySingleton<UberCancelTripUseCase>(
      () => UberCancelTripUseCase(uberMapRepository: sl.call()));

  // repository
  sl.registerLazySingleton<UberMapRepository>(
      () => UberMapRepositoryImpl(uberMapDataSource: sl.call()));

  //datasource
  sl.registerLazySingleton<UberMapDataSource>(() => UberMapDataSourceImpl(
      client: sl.call(), firestore: sl.call(), auth: sl.call()));
  sl.registerLazySingleton(() => http.Client());

// profile feature

  //getx

  sl.registerFactory<UberProfileController>(() => UberProfileController(
      uberProfileGetRiderProfileUsecase: sl.call(),
      uberProfileUpdateRiderUsecase: sl.call()));
  //usecase

  sl.registerLazySingleton<UberProfileGetRiderProfileUsecase>(() =>
      UberProfileGetRiderProfileUsecase(uberProfileRepository: sl.call()));

  sl.registerLazySingleton<UberProfileUpdateRiderUsecase>(
      () => UberProfileUpdateRiderUsecase(uberProfileRepository: sl.call()));
  //repository

  sl.registerLazySingleton<UberProfileRepository>(
      () => UberProfileRepositoryImpl(uberProfileDataSource: sl.call()));
  //datasource
  sl.registerLazySingleton<UberProfileDataSource>(
      () => UberProfileDataSourceImpl(firestore: sl.call(), auth: sl.call()));
  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
