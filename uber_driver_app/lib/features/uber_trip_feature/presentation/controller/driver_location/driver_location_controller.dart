
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_driver_app/features/uber_trip_feature/domain/use_cases/driver_location_usecase.dart';


class DriverLocationController extends GetxController  {
final DriverLocationUseCase driverLocationUseCase;


DriverLocationController({required this.driverLocationUseCase});
  late Position currentPosition;

  changePosition(Position position, GoogleMapController controller, BuildContext context){
    currentPosition = position;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 18.0,
        ),
      ),
    );
  }


}