import 'package:uber_rider_app/features/uber_trips_history_feature/domain/repositories/uber_trips_history_repository.dart';

class UberGiveTripRatingUsecase {
  final UberTripHistoryRepository uberTripHistoryRepository;

  UberGiveTripRatingUsecase({required this.uberTripHistoryRepository});

  Future<void> call(double rating, String tripId, String driverId) async {
    return await uberTripHistoryRepository.uberGiveTripRating(
        rating, tripId, driverId);
  }
}
