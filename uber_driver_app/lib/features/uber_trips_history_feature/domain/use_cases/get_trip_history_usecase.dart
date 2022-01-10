import 'package:uber_driver_app/core/usecases/common/usecase.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/entities/trip_entity.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/repositories/trip_history_repository.dart';

class TripHistoryUseCase extends UseCase<List<TripEntity>, Params> {
  final TripHistoryRepository repository;

  TripHistoryUseCase({required this.repository});

  @override
  Stream<List<TripEntity>> call(Params params) {
    return repository.tripDriverStream(
        params.type as bool, params as String, params.type as String);
  }

  @override
  Future<void>? call2(Params params) {
    // TODO: implement call2
    throw UnimplementedError();
  }
}
