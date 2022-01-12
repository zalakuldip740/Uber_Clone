import 'package:uber_rider_app/features/uber_map_feature/domain/entities/uber_map_get_drivers_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/data/data_sources/uber_trips_history_data_source.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/repositories/uber_trips_history_repository.dart';

class UberTripHistoryRepositoryImpl extends UberTripHistoryRepository {
  final UberTripsHistoryDataSource uberTripsHistoryDataSource;

  UberTripHistoryRepositoryImpl({required this.uberTripsHistoryDataSource});

  @override
  Stream<List<TripHistoryEntity>> uberGetTripHistory(String riderId, int page) {
    return uberTripsHistoryDataSource.uberGetTripHistory(riderId, page);
  }

  @override
  Future<void> uberGiveTripRating(
      double rating, String tripId, String driverId) async {
    return await uberTripsHistoryDataSource.uberGiveTripRating(
        rating, tripId, driverId);
  }

  @override
  Future<UberDriverEntity> uberGetTripDriver(String driverId) async {
    return await uberTripsHistoryDataSource.uberGetTripDriver(driverId);
  }
}
