part of 'uber_map_cubit.dart';

abstract class UberMapState extends Equatable {
  const UberMapState();
}

class UberMapInitial extends UberMapState {
  @override
  List<Object> get props => [];
}
class UberMapLoading extends UberMapState {
  @override
  List<Object> get props => [];
}

class UberMapLoaded extends UberMapState {
  final  Map<MarkerId, Marker> markers;
 final Map<PolylineId, Polyline> polylines;

  const UberMapLoaded({required this.markers, required this.polylines});

  @override
  List<Object> get props => [];
}
