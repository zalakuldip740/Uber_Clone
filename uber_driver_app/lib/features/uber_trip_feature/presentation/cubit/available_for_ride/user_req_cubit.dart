import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:meta/meta.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_driver_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';
import 'package:uber_driver_app/features/uber_trip_feature/domain/use_cases/driver_update_usecase.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/driver_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/rider_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/uber_trips_history_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/entities/trip_entity.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/use_cases/get_trip_history_usecase.dart';
import 'package:uber_driver_app/injection_container.dart' as di;

part 'user_req_state.dart';

class UserReqCubit extends Cubit<UserReqState> {
  final UberProfileController _uberProfileController =
      Get.put(di.sl<UberProfileController>());
  final TripHistoryUseCase tripHistoryUseCase;
  final DriverUpdateUseCase driverUpdateUseCase;
  final UberAuthGetUserUidUseCase getUserUidUseCase;
  bool accept = false;
  TripEntity? tripDriverUpdated;

  UserReqCubit({
    required this.driverUpdateUseCase,
    required this.tripHistoryUseCase,
    required this.getUserUidUseCase,
  }) : super(UserReqInitial());

  //stream for fetching all trips assigned to this driver
  getUserReq() async {
    try {
      emit(UserReqLoading());
      String driverId =
          await getUserUidUseCase.uberAuthRepository.uberAuthGetUserUid();

      if (accept == false) {
        //load all trips assigned to driver
        final Stream<List<TripEntity>> tripHistoryList =
            tripHistoryUseCase.repository.tripDriverStream(
                false,
                driverId,
                accept == false
                    ? null
                    : tripDriverUpdated!.tripHistoryModel.tripId);
        tripHistoryList.listen((event) {
          if (accept == false) {
            emit(UserReqLoaded(tripHistoryList: event));
          } else {
            final Stream<List<TripEntity>> tripHistoryList =
                tripHistoryUseCase.repository.tripDriverStream(
                    false,
                    driverId,
                    accept == false
                        ? null
                        : tripDriverUpdated!.tripHistoryModel.tripId);
            tripHistoryList.listen((event) {
              emit(UserReqDisplayOne(tripDriver: event[0]));
            });
          }
        });
      } else {
        //add current trip data to history page
        final Stream<List<TripEntity>> tripHistoryList =
            tripHistoryUseCase.repository.tripDriverStream(
                false,
                driverId,
                accept == false
                    ? null
                    : tripDriverUpdated!.tripHistoryModel.tripId);
        tripHistoryList.listen((event) {
          emit(UserReqDisplayOne(tripDriver: event[0]));
        });
      }
    } catch (e) {
      print(e);
      emit(UserReqFailureState(e.toString()));
    }
  }

  //clear last ride data from request list
  readyForNextRide(bool isAccept) {
    accept = isAccept;
    getUserReq();
  }

  //method after trip is accepted by driver
  isAccept(TripEntity tripDriver, bool isDriver, bool isCompleted) async {
    accept = true;
    tripDriverUpdated = tripDriver;
    final String driverId =
        await getUserUidUseCase.uberAuthRepository.uberAuthGetUserUid();
    await _uberProfileController.getDriverProfile();
    final driver = _uberProfileController.driverEntity;

    try {
      await driverUpdateUseCase.repository.updateDriverAndTrip(
          TripEntity(
              TripHistoryModel(
                destinationLocation:
                    tripDriver.tripHistoryModel.destinationLocation,
                destination: tripDriver.tripHistoryModel.destination,
                tripId: tripDriver.tripHistoryModel.tripId,
                distance: tripDriver.tripHistoryModel.distance,
                source: tripDriver.tripHistoryModel.source,
                isCompleted: tripDriver.tripHistoryModel.isArrived == true &&
                        isCompleted == false
                    ? true
                    : tripDriver.tripHistoryModel.isCompleted,
                travellingTime: tripDriver.tripHistoryModel.travellingTime,
                tripDate: tripDriver.tripHistoryModel.tripDate.toString(),
                tripAmount: tripDriver.tripHistoryModel.tripAmount,
                rating: tripDriver.tripHistoryModel.rating,
                sourceLocation: tripDriver.tripHistoryModel.sourceLocation,
                ready_for_trip: isDriver == true
                    ? accept
                    : tripDriver.tripHistoryModel.ready_for_trip,
                riderId: tripDriver.tripHistoryModel.riderId,
                isArrived: isDriver == true
                    ? tripDriver.tripHistoryModel.isArrived
                    : true,
              ),
              RiderModel(
                  rider_id: tripDriver.riderModel.rider_id,
                  mobile: tripDriver.riderModel.mobile,
                  name: tripDriver.riderModel.name)),
          DriverModel(
            is_online: false,
            driver_id: driverId,
            profile_img: driver.profile_img,
            current_location: driver.current_location,
          ),
          isDriver);
    } catch (e) {
      print(e);
      emit(UserReqFailureState(e.toString()));
    }
  }
}
