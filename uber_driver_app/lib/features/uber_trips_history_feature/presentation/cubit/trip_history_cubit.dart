import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/entities/trip_entity.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/use_cases/get_trip_history_usecase.dart';

part 'trip_history_state.dart';

class TripHistoryCubit extends Cubit<TripHistoryState> {
  final TripHistoryUseCase tripHistoryUseCase;
  final UberAuthGetUserUidUseCase getUserUidUseCase;

  TripHistoryCubit(
      {required this.tripHistoryUseCase,required this.getUserUidUseCase})
      : super(TripHistoryInitial());

  getTripHistory() async{
    try {
      emit(const TripHistoryLoading());
      final driverId=await getUserUidUseCase.uberAuthRepository.uberAuthGetUserUid();
      final Stream<List<TripEntity>> tripHistoryList =
      tripHistoryUseCase.repository.tripDriverStream(true,driverId,null);
      tripHistoryList.listen((event) {
        emit(TripHistoryLoaded(tripHistoryList: event));
      });
    } catch (e) {
      print(e);
      emit(TripHistoryFailureState(e.toString()));
    }
  }
}