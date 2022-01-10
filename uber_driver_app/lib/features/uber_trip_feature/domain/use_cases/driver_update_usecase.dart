
import 'package:uber_driver_app/core/usecases/common/usecase.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/driver_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/entities/trip_entity.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/repositories/trip_history_repository.dart';

class DriverUpdateUseCase extends UseCase<TripEntity, Params>{
  final TripHistoryRepository repository;
  DriverUpdateUseCase({required this.repository});

  @override
  Stream<TripEntity>? call(Params params) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  Future<void> call2(Params params) {
    return repository.updateDriverAndTrip(params.type as TripEntity,params.type as DriverModel,params.type as bool);
  }
}