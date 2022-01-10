
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/driver_entity.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberProfileGetDriverProfileUsecase {
  final UberProfileRepository uberProfileRepository;
  UberProfileGetDriverProfileUsecase({required this.uberProfileRepository});

  Stream<DriverEntity> call(String driverId) {
    return uberProfileRepository.getDriverProfile(driverId);
  }
}
