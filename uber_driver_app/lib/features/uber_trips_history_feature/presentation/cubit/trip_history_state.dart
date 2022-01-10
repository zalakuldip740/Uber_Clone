part of 'trip_history_cubit.dart';

abstract class TripHistoryState extends Equatable {
  const TripHistoryState();
}

class TripHistoryInitial extends TripHistoryState {
  @override
  List<Object> get props => [];
}

class TripHistoryLoading extends TripHistoryState{
  const TripHistoryLoading();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}



class TripHistoryLoaded extends TripHistoryState{
  final List<TripEntity> tripHistoryList;
  const TripHistoryLoaded({required this.tripHistoryList});

  @override
  // TODO: implement props
  List<Object?> get props => [tripHistoryList];
}

class TripHistoryFailureState extends TripHistoryState {
  final String message;

  TripHistoryFailureState(this.message);
  @override
  List<Object> get props => [message];
}