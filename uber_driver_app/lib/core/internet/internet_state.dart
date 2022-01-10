

part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();
}

class InternetLoading  extends InternetState {
  @override
  List<Object> get props => [];
}
class InternetConnected extends InternetState {
  final ConnectionType? connectionType;

  const InternetConnected({required this.connectionType});

  @override
  // TODO: implement props
  List<Object?> get props => [connectionType];
}

class InternetDisconnected extends InternetState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}