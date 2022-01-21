import 'package:geolocator/geolocator.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/domain/repositories/user_current_location_repository.dart';

class GetUserCurrentLocationUsecase {
  final UserCurrentLocationRepository userCurrentLocationRepository;

  GetUserCurrentLocationUsecase({required this.userCurrentLocationRepository});

  Future<Position> call() async {
    return await userCurrentLocationRepository.getUserCurrentLocation();
  }
}
