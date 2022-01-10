import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_driver_app/features/uber_trip_feature/domain/use_cases/driver_location_usecase.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/controller/driver_location/driver_location_controller.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/driver_model.dart';
import 'package:uber_driver_app/injection_container.dart' as di;

part 'driver_location_state.dart';

class DriverLocationCubit extends Cubit<DriverLocationState> {
  final DriverLocationUseCase driverLocationUseCase;
  final UberAuthGetUserUidUseCase getUserUidUseCase;
  bool is_online = false;

  final c = Get.put(di.sl<DriverLocationController>());
  Completer<GoogleMapController> mapController = Completer();
  Timer? _timer;

  DriverLocationCubit(
      {required this.driverLocationUseCase, required this.getUserUidUseCase})
      : super(DriverLocationInitial());

  //stream for getting driver's updated location
  getDriverLocation() async {
    try {
      emit(DriverLocationLoading());
      final String driverId =
          await getUserUidUseCase.uberAuthRepository.uberAuthGetUserUid();
      final Stream<DriverModel> driverStream =
          driverLocationUseCase.repository.tripDriverStream(driverId);
      driverStream.listen((event) {
        emit(DriverLocationLoaded(driverModel: event));
      });
    } catch (e) {
      print(e);
    }
  }

  //method for updating driver data
  updateDriver(bool isOnline, DriverModel driverModel) async {
    final String driverId =
        await getUserUidUseCase.uberAuthRepository.uberAuthGetUserUid();
    try {
      final model = DriverLocationModel(
        is_online: isOnline,
        driver_id: driverId,
        current_location: driverModel.current_location,
      );
      await driverLocationUseCase.repository.updateDriver(model);
      getDriverLocation();
    } catch (e) {
      print(e);
    }
  }

  //method for uploading current location every minute
  updateDriverLocationEveryMinute(
      GeoPoint geoPoint, DriverModel driverModel, bool is_online) async {
    try {
      final model = DriverLocationModel(
        is_online: is_online,
        current_location: geoPoint,
        driver_id: driverModel.driver_id,
      );
      driverLocationUseCase.repository.updateDriver(model);
      getDriverLocation();
    } catch (e) {
      print(e);
    }
  }

  //timer for uploading current location every minute
  void startTimer(DriverModel driverModel) {
    if (is_online == true) {
      _timer = Timer(const Duration(minutes: 1), () async {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .then((Position position) async {
          updateDriverLocationEveryMinute(
              GeoPoint(position.latitude, position.longitude),
              driverModel,
              is_online);
        }).catchError((e) {
          print(e);
        });
        _timer!.cancel();
        if (is_online == true) {
          startTimer(driverModel);
        }
      });
    } else {
      cancelTimer();
    }
  }

  //cancel 1 min timer
  cancelTimer() {
    try {
      _timer!.cancel();
    } catch (e) {
      print(e);
    }
  }

  // Method for retrieving the current location
  getCurrentLocation(BuildContext context) async {
    LocationPermission permission;

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
      }
      else if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Alert",
          "Location permissions are permanently denied,please enable it from app setting",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }  else if (permission ==LocationPermission.whileInUse ||permission ==LocationPermission.always){
      final GoogleMapController controller = await mapController.future;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        c.changePosition(position, controller, context);
      }).catchError((e) {
        print(e);
      });
    }
    else{
      Get.snackbar(
        "Alert",
        "Location permissions are permanently denied,please enable it from app setting",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


}
