import 'package:uber_rider_app/features/uber_profile_feature/data/models/uber_profile_rider_model.dart';

abstract class UberProfileDataSource {
  Future<RiderModel> getRiderProfile(String riderId);
  Future<void> updateRiderProfile(RiderModel riderModel, String riderId);
}
