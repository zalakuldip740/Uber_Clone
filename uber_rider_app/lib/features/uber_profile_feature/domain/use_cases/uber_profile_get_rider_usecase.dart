import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberProfileGetRiderProfileUsecase {
  final UberProfileRepository uberProfileRepository;

  UberProfileGetRiderProfileUsecase({required this.uberProfileRepository});

  Stream<RiderEntity> call(String riderId) {
    return uberProfileRepository.getRiderProfile(riderId);
  }
}
