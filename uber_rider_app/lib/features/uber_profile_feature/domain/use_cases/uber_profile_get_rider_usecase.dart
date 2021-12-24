import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberProfileGetRiderProfileUsecase {
  final UberProfileRepository uberProfileRepository;
  UberProfileGetRiderProfileUsecase({required this.uberProfileRepository});

  Future<RiderEntity> call(String riderId) async {
    return uberProfileRepository.getRiderProfile(riderId);
  }
}
