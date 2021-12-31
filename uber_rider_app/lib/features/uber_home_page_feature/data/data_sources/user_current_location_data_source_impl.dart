import 'package:geolocator/geolocator.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/data/data_sources/user_current_location_data_source.dart';

class UserCurrentLocationDataSourceImpl extends UserCurrentLocationDataSource {
  @override
  Future<Position> getUserCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
