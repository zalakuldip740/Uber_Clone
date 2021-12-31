import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/getx/uber_trip_history_controller.dart';

void showRatingAppDialog(
    BuildContext context,
    TripHistoryEntity tripHistoryEntity,
    UberTripsHistoryController uberTripsHistoryController) {
  final _ratingDialog = RatingDialog(
    starColor: Colors.amber,
    title: Text(
      tripHistoryEntity.driverName.toString(),
      textAlign: TextAlign.center,
    ),
    message: const Text(
      'Rate Your Journey',
      textAlign: TextAlign.center,
    ),
    image: const CircleAvatar(
      radius: 42,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
            "https://images.unsplash.com/profile-1533651674518-3723fed8d396?dpr=1&auto=format&fit=crop&w=150&h=150&q=60&crop=faces&bg=fff"),
        radius: 40,
      ),
    ),
    submitButtonText: 'Submit',
    onSubmitted: (response) {
      uberTripsHistoryController.giveTripRating(
          response.rating, tripHistoryEntity.tripId.toString());
    },
  );

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => _ratingDialog,
  );
}
