import 'package:geolocator/geolocator.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/data/data_sources/user_current_location_data_source.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/domain/repositories/user_current_location_repository.dart';

class UserCurrentLocationRepositoryImpl extends UserCurrentLocationRepository {
  final UserCurrentLocationDataSource userCurrentLocationDataSource;

  UserCurrentLocationRepositoryImpl(
      {required this.userCurrentLocationDataSource});

  @override
  Future<Position> getUserCurrentLocation() async {
    return await userCurrentLocationDataSource.getUserCurrentLocation();
  }
}
