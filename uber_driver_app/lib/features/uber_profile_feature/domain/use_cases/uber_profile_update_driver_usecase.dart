
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/driver_entity.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberProfileUpdateDriverUsecase {
  final UberProfileRepository uberProfileRepository;
  UberProfileUpdateDriverUsecase({required this.uberProfileRepository});

  Future<void> call(DriverEntity driverEntity, String driverId) async {
    return await uberProfileRepository.updateDriverProfile(driverEntity, driverId);
  }
}
