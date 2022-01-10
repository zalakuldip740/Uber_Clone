part of 'driver_location_cubit.dart';

abstract class DriverLocationState extends Equatable {
  const DriverLocationState();
}

class DriverLocationInitial extends DriverLocationState {
  @override
  List<Object> get props => [];
}

class  DriverLocationLoading extends DriverLocationState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class  DriverLocationLoaded extends DriverLocationState{
  final DriverModel driverModel;
  const DriverLocationLoaded({required this.driverModel});

  @override
  // TODO: implement props
  List<Object?> get props => [driverModel];
}


class  DriverLocationFailureState extends DriverLocationState {
  final String message;

  DriverLocationFailureState(this.message);
  @override
  List<Object> get props => [message];
}
