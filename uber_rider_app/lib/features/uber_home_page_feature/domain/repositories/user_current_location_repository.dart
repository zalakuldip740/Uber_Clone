import 'package:geolocator/geolocator.dart';

abstract class UserCurrentLocationRepository {
  Future<Position> getUserCurrentLocation();
}
