import 'package:uber_rider_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/models/uber_profile_rider_model.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberProfileRepositoryImpl extends UberProfileRepository {
  final UberProfileDataSource uberProfileDataSource;

  UberProfileRepositoryImpl({required this.uberProfileDataSource});

  @override
  Stream<RiderModel> getRiderProfile(String riderId) {
    return uberProfileDataSource.getRiderProfile(riderId);
  }

  @override
  Future<void> updateRiderProfile(
      RiderEntity riderEntity, String riderId) async {
    final riderModel = RiderModel(
        name: riderEntity.name,
        email: riderEntity.email,
        phoneNumber: riderEntity.phoneNumber,
        city: riderEntity.city,
        profileUrl: riderEntity.profileUrl,
        homeAddress: riderEntity.homeAddress,
        workAddress: riderEntity.workAddress,
        wallet: riderEntity.wallet);
    return await uberProfileDataSource.updateRiderProfile(riderModel, riderId);
  }

  @override
  Future<void> walletAddMoney(String riderId, int addAmt) async {
    return await uberProfileDataSource.walletAddMoney(riderId, addAmt);
  }
}
