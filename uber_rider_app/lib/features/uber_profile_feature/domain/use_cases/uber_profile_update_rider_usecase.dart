import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberProfileUpdateRiderUsecase {
  final UberProfileRepository uberProfileRepository;

  UberProfileUpdateRiderUsecase({required this.uberProfileRepository});

  Future<void> call(RiderEntity riderEntity, String riderId) async {
    return await uberProfileRepository.updateRiderProfile(riderEntity, riderId);
  }
}
