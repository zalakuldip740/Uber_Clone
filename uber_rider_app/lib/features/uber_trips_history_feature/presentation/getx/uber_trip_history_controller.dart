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
  var page = 1.obs;
  var isMoreLoading = false.obs;

  getTripsHistory() async {
    //tripsHistory.clear();
    if (tripsHistory.isNotEmpty) {
      isMoreLoading.value = true;
    }
    String riderId = await uberAuthGetUserUidUseCase.call();
    final tripsHistoryData =
        uberGetTripHistoryUsecase.call(riderId, page.value);
    tripsHistoryData.listen((data) async {
      // if (tripsHistory.value.length <= data.length) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].driverId != null) {
          final driverId = data[i].driverId!.path.split('/').last.trim();
          await uberGetTripDriverUsecase.call(driverId).then((driverData) {
            tripDrivers[driverId] = driverData;
          });
        }
      }
      tripsHistory.value = data;
      page.value++;
      // }
      // else {
      //   Get.snackbar("Sorry", "No more Data!",
      //       snackPosition: SnackPosition.BOTTOM);
      // }
      isTripLoaded.value = true;
      isMoreLoading.value = false;
    });
  }

  giveTripRating(double rating, String tripId, String driverId) async {
    await uberGiveTripRatingUsecase.call(rating, tripId, driverId);
  }
}
