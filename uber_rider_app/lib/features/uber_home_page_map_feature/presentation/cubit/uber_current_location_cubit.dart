import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/domain/use_cases/get_user_current_location_usecase.dart';

part 'uber_current_location_state.dart';

class UberCurrentLocationCubit extends Cubit<UberCurrentLocationState> {
  final GetUserCurrentLocationUsecase getUserCurrentLocationUsecase;

  UberCurrentLocationCubit({required this.getUserCurrentLocationUsecase})
      : super(UberCurrentLocationInitial());

  getUserCurrentLocation() async {
    LocationPermission permission;
    //permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Alert",
          "Location permissions are denied",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
        emit(UberCurrentLocationDeny(msg: "Location permissions are denied"));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Alert",
        "Location permissions are permanently denied,please enable it from app setting",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
      emit(UberCurrentLocationDenyForever(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.'));
    } else {
      //Position position = await Geolocator.getCurrentPosition();
      Position position = await getUserCurrentLocationUsecase.call();
      emit(UberCurrentLocationGranted(position: position));
    }
  }
}
