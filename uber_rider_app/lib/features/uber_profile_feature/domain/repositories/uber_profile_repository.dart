import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';

abstract class UberProfileRepository {
  Stream<RiderEntity> getRiderProfile(String riderId);

  Future<void> updateRiderProfile(RiderEntity riderEntity, String riderId);

  Future<void> walletAddMoney(String riderId, int addAmt);
}
