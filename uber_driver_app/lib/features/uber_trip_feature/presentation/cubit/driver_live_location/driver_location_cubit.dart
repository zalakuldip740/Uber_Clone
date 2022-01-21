import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_driver_app/features/uber_trip_feature/domain/use_cases/driver_location_usecase.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/driver_model.dart';

part 'driver_location_state.dart';

class DriverLocationCubit extends Cubit<DriverLocationState> {
  final DriverLocationUseCase driverLocationUseCase;
  final UberAuthGetUserUidUseCase getUserUidUseCase;
  bool is_online = false;
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
}
