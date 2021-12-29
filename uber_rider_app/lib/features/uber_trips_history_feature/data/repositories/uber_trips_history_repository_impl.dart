import 'package:uber_rider_app/features/uber_trips_history_feature/data/data_sources/uber_trips_history_data_source.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/repositories/uber_trips_history_repository.dart';

class UberTripHistoryRepositoryImpl extends UberTripHistoryRepository {
  final UberTripsHistoryDataSource uberTripsHistoryDataSource;

  UberTripHistoryRepositoryImpl({required this.uberTripsHistoryDataSource});

  @override
  Stream<List<TripHistoryEntity>> uberGetTripHistory(String riderId) {
    return uberTripsHistoryDataSource.uberGetTripHistory(riderId);
  }

  @override
  Future<void> uberGiveTripRating(double rating, String tripId) async {
    return await uberTripsHistoryDataSource.uberGiveTripRating(rating, tripId);
  }
}
