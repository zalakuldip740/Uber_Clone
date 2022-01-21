import 'package:uber_rider_app/features/uber_map_feature/domain/repositories/uber_map_repository.dart';

class UberCancelTripUseCase {
  final UberMapRepository uberMapRepository;

  UberCancelTripUseCase({required this.uberMapRepository});

  Future<void> call(String tripId, bool isNewTripGeneration) async {
    return await uberMapRepository.cancelTrip(tripId, isNewTripGeneration);
  }
}
