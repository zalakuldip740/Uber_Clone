import 'package:uber_rider_app/features/uber_map_feature/domain/entities/uber_map_get_drivers_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/repositories/uber_trips_history_repository.dart';

class UberGetTripDriverUsecase {
  final UberTripHistoryRepository uberTripHistoryRepository;

  UberGetTripDriverUsecase({required this.uberTripHistoryRepository});

  Future<UberDriverEntity> call(String driverId) async {
    return await uberTripHistoryRepository.uberGetTripDriver(driverId);
  }
}
