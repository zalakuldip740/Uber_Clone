import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';

abstract class UberTripHistoryRepository {
  Stream<List<TripHistoryEntity>> uberGetTripHistory(String riderId);

  Future<void> uberGiveTripRating(double rating, String tripId);
}
