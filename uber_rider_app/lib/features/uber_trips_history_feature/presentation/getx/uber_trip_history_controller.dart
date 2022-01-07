import 'package:get/get.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/entities/uber_map_get_drivers_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/use_cases/uber_get_trip_driver_usecase.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/use_cases/uber_get_trip_history_usecase.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/use_cases/uber_give_trip_rating_usecase.dart';

class UberTripsHistoryController extends GetxController {
  final UberGetTripHistoryUsecase uberGetTripHistoryUsecase;
  final UberGiveTripRatingUsecase uberGiveTripRatingUsecase;
  final UberAuthGetUserUidUseCase uberAuthGetUserUidUseCase;
  final UberGetTripDriverUsecase uberGetTripDriverUsecase;

  UberTripsHistoryController(
      {required this.uberGetTripHistoryUsecase,
      required this.uberGiveTripRatingUsecase,
      required this.uberAuthGetUserUidUseCase,
      required this.uberGetTripDriverUsecase});

  var isTripLoaded = false.obs;
  var tripsHistory = <TripHistoryEntity>[].obs;
  var tripDrivers = <String, UberDriverEntity>{}.obs;

  getTripsHistory() async {
    tripsHistory.clear();
    String riderId = await uberAuthGetUserUidUseCase.call();
    final tripsHistoryData = uberGetTripHistoryUsecase.call(riderId);
    tripsHistoryData.listen((data) async {
      tripsHistory.value = data;
      for (int i = 0; i < data.length; i++) {
        if (data[i].driverId != null) {
          final driverId = data[i].driverId!.path.split('/').last.trim();
          await uberGetTripDriverUsecase.call(driverId).then((driverData) {
            tripDrivers[driverId] = driverData;
          });
        }
      }
      isTripLoaded.value = true;
    });
  }

  giveTripRating(double rating, String tripId, String driverId) async {
    await uberGiveTripRatingUsecase.call(rating, tripId, driverId);
  }
}
