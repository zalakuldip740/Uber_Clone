import 'package:geolocator/geolocator.dart';

abstract class UserCurrentLocationDataSource {
  Future<Position> getUserCurrentLocation();
}
