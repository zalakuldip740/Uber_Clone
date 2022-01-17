import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:uber_rider_app/core/network_checker/uber_network_checker_controller.dart';
import 'package:uber_rider_app/features/uber_auth_feature/data/data_sources/uber_auth_data_source.dart';
import 'package:uber_rider_app/features/uber_auth_feature/data/data_sources/uber_auth_data_source_impl.dart';
import 'package:uber_rider_app/features/uber_auth_feature/data/repositories/uber_auth_repository_impl.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_add_profile_image_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_check_user_status_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_is_sign_in_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_otp_verification_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_phone_verification_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_sign_out_usecase.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/getx/uber_home_controller.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/data_sources/uber_map_data_source.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/data_sources/uber_map_data_source_impl.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/repositories/uber_map_repository_impl.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/repositories/uber_map_repository.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/cancel_trip_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/uber_map_direction_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/uber_map_get_drivers_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/uber_map_prediction_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/uber_trip_payment_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/use_cases/vehicle_details_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/getx/uber_map_controller.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source_impl.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/repositories/uber_profile_repository_impl.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_profile_get_rider_usecase.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_wallet_add_money_usecase.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/data/data_sources/uber_trips_history_data_source.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/data/repositories/uber_trips_history_repository_impl.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/repositories/uber_trips_history_repository.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/use_cases/uber_get_trip_driver_usecase.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/use_cases/uber_get_trip_history_usecase.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/use_cases/uber_give_trip_rating_usecase.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/getx/uber_trip_history_controller.dart';

import 'features/uber_auth_feature/presentation/getx/auth_controller.dart';
import 'features/uber_home_page_feature/data/data_sources/user_current_location_data_source.dart';
import 'features/uber_home_page_feature/data/data_sources/user_current_location_data_source_impl.dart';
import 'features/uber_home_page_feature/data/repositories/user_current_location_repository_impl.dart';
import 'features/uber_home_page_feature/domain/repositories/user_current_location_repository.dart';
import 'features/uber_home_page_feature/domain/use_cases/get_user_current_location_usecase.dart';
import 'features/uber_map_feature/domain/use_cases/generate_trip_usecase.dart';
import 'features/uber_map_feature/domain/use_cases/get_rental_charges_usecase.dart';
import 'features/uber_map_feature/presentation/getx/uber_live_tracking_controller.dart';
import 'features/uber_profile_feature/domain/use_cases/uber_profile_update_rider_usecase.dart';
import 'features/uber_trips_history_feature/data/data_sources/uber_trips_history_data_source_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //network getx

  sl.registerFactory<UberNetWorkStatusChecker>(
      () => UberNetWorkStatusChecker());

  // feature:- current location
  //getx
  sl.registerFactory<UberHomeController>(
      () => UberHomeController(getUserCurrentLocationUsecase: sl.call()));

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
      uberCancelTripUseCase: sl.call(),
      uberAuthGetUserUidUseCase: sl.call()));
  sl.registerFactory<UberLiveTrackingController>(() =>
      UberLiveTrackingController(
          uberMapDirectionUsecase: sl.call(),
          uberTripPaymentUseCase: sl.call()));
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
  sl.registerLazySingleton<UberTripPaymentUseCase>(
      () => UberTripPaymentUseCase(uberMapRepository: sl.call()));

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
      uberProfileUpdateRiderUsecase: sl.call(),
      uberAuthGetUserUidUseCase: sl.call(),
      uberAuthSignOutUseCase: sl.call(),
      uberAddProfileImgUseCase: sl.call(),
      uberWalletAddMoneyUsecase: sl.call()));
  //usecase

  sl.registerLazySingleton<UberProfileGetRiderProfileUsecase>(() =>
      UberProfileGetRiderProfileUsecase(uberProfileRepository: sl.call()));

  sl.registerLazySingleton<UberProfileUpdateRiderUsecase>(
      () => UberProfileUpdateRiderUsecase(uberProfileRepository: sl.call()));

  sl.registerLazySingleton<UberWalletAddMoneyUsecase>(
      () => UberWalletAddMoneyUsecase(uberProfileRepository: sl.call()));
  //repository

  sl.registerLazySingleton<UberProfileRepository>(
      () => UberProfileRepositoryImpl(uberProfileDataSource: sl.call()));
  //datasource
  sl.registerLazySingleton<UberProfileDataSource>(
      () => UberProfileDataSourceImpl(firestore: sl.call(), auth: sl.call()));

  // auth feature

  //getx

  sl.registerFactory<UberAuthController>(() => UberAuthController(
      uberAuthIsSignInUseCase: sl.call(),
      uberAuthPhoneVerificationUseCase: sl.call(),
      uberAuthOtpVerificationUseCase: sl.call(),
      uberAuthCheckUserStatusUseCase: sl.call(),
      uberAuthGetUserUidUseCase: sl.call(),
      uberProfileUpdateRiderUsecase: sl.call(),
      uberAddProfileImgUseCase: sl.call()));
  //usecase

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
  sl.registerLazySingleton<UberAddProfileImgUseCase>(
      () => UberAddProfileImgUseCase(uberAuthRepository: sl.call()));

  //repository

  sl.registerLazySingleton<UberAuthRepository>(
      () => UberAuthRepositoryImpl(uberAuthDataSource: sl.call()));
  //datasource

  sl.registerLazySingleton<UberAuthDataSource>(() => UberAuthDataSourceImpl(
      firestore: sl.call(), auth: sl.call(), firebaseStorage: sl.call()));

  // history feature

  //getx

  sl.registerFactory<UberTripsHistoryController>(() =>
      UberTripsHistoryController(
          uberGetTripHistoryUsecase: sl.call(),
          uberGiveTripRatingUsecase: sl.call(),
          uberAuthGetUserUidUseCase: sl.call(),
          uberGetTripDriverUsecase: sl.call()));

  //usecase

  sl.registerLazySingleton<UberGetTripHistoryUsecase>(
      () => UberGetTripHistoryUsecase(uberTripHistoryRepository: sl.call()));
  sl.registerLazySingleton<UberGiveTripRatingUsecase>(
      () => UberGiveTripRatingUsecase(uberTripHistoryRepository: sl.call()));
  sl.registerLazySingleton<UberGetTripDriverUsecase>(
      () => UberGetTripDriverUsecase(uberTripHistoryRepository: sl.call()));

  //repository

  sl.registerLazySingleton<UberTripHistoryRepository>(() =>
      UberTripHistoryRepositoryImpl(uberTripsHistoryDataSource: sl.call()));

  //datasource

  sl.registerLazySingleton<UberTripsHistoryDataSource>(
      () => UberTripsHistoryDataSourceImpl(firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => firebaseStorage);
}
