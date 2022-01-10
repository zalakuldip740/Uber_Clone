import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/pages/uber_home_page.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/getx/uber_trip_history_controller.dart';

void showRatingAppDialog(
    BuildContext context,
    TripHistoryEntity tripHistoryEntity,
    UberTripsHistoryController uberTripsHistoryController) {
  final driverId = tripHistoryEntity.driverId!.path.split('/').last.trim();
  final _ratingDialog = RatingDialog(
    starSize: 30,
    starColor: Colors.amber,
    title: Text(
      uberTripsHistoryController.tripDrivers.value[driverId]!.name.toString(),
      textAlign: TextAlign.center,
    ),
    message: const Text(
      'Rate Your Journey',
      textAlign: TextAlign.center,
    ),
    image: CircleAvatar(
      radius: 42,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(uberTripsHistoryController
            .tripDrivers.value[driverId]!.profile_img
            .toString()),
        radius: 40,
      ),
    ),
    submitButtonText: 'Submit',
    onSubmitted: (response) {
      uberTripsHistoryController.giveTripRating(
          response.rating,
          tripHistoryEntity.tripId.toString(),
          tripHistoryEntity.driverId!.path.split('/').last.trim());
      Get.offAll(() => const UberHomePage());
    },
  );

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => _ratingDialog,
  );
}
