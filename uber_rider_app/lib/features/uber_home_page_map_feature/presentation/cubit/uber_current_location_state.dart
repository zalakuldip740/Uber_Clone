part of 'uber_current_location_cubit.dart';

abstract class UberCurrentLocationState extends Equatable {
  const UberCurrentLocationState();
}

class UberCurrentLocationInitial extends UberCurrentLocationState {
  @override
  List<Object> get props => [];
}

class UberCurrentLocationDeny extends UberCurrentLocationState {
  String msg;
  UberCurrentLocationDeny({required this.msg});
  @override
  List<Object> get props => [msg];
}

class UberCurrentLocationDenyForever extends UberCurrentLocationState {
  String msg;
  UberCurrentLocationDenyForever({required this.msg});
  @override
  List<Object> get props => [msg];
}

class UberCurrentLocationGranted extends UberCurrentLocationState {
  Position position;
  UberCurrentLocationGranted({required this.position});
  @override
  List<Object> get props => [position];
}
