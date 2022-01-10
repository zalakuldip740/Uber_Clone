
import 'package:uber_driver_app/core/usecases/common/usecase.dart';
import 'package:uber_driver_app/features/uber_trip_feature/domain/repositories/driver_location_repository.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/driver_model.dart';

class DriverLocationUseCase extends UseCase<DriverModel, Params>{
  final DriverLocationRepository repository;
  DriverLocationUseCase({required this.repository});

  @override
  Stream<DriverModel> call(Params params) {
    return repository.tripDriverStream(params.type as String);
  }

  @override
  Future<void>? call2(Params params) {
    return repository.updateDriver(params.type as DriverModel);
  }

}