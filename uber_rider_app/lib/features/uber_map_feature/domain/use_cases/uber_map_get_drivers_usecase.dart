import 'package:uber_rider_app/features/uber_map_feature/domain/entities/uber_map_get_drivers_entity.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/repositories/uber_map_repository.dart';

class UberMapGetDriversUsecase {
  final UberMapRepository uberMapRepository;
  UberMapGetDriversUsecase({required this.uberMapRepository});
  Stream<List<UberGetAvailableDriversEntity>> call() {
    return uberMapRepository.getAvailableDrivers();
  }
}
