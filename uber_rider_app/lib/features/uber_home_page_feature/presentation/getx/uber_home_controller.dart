import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/domain/use_cases/get_user_current_location_usecase.dart';

class UberHomeController extends GetxController {
  final GetUserCurrentLocationUsecase getUserCurrentLocationUsecase;

  var currentLat = 23.030357.obs;
  var currentLng = 72.517845.obs;
  final Completer<GoogleMapController> controller = Completer();

  // @override
  // void onInit() {
  //   getUserCurrentLocation();
  //   super.onInit();
  // }
  UberHomeController({required this.getUserCurrentLocationUsecase});

  getUserCurrentLocation() async {
    animateCamera(); //if allowded firstly
    LocationPermission permission;
    await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Alert",
          "Location permissions are denied",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Alert",
        "Location permissions are permanently denied,please enable it from app setting",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      animateCamera();
    }
  }

  animateCamera() async {
    await getUserCurrentLocationUsecase.call().then((value) {
      currentLat.value = value.latitude;
      currentLng.value = value.longitude;
    });
    final GoogleMapController _controller = await controller.future;
    CameraPosition _newCameraPos = CameraPosition(
      target: LatLng(currentLat.value, currentLng.value),
      zoom: 14.4746,
    );
    _controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPos));
  }
}
