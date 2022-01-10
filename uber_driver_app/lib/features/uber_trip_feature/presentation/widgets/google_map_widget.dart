import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/uber_driver_map/uber_map_cubit.dart';

class GoogleMapWidget extends StatelessWidget {
  Map<MarkerId, Marker> markers;
  Map<PolylineId, Polyline> polylines;
  GoogleMapWidget(this.markers, this.polylines);

  @override
  Widget build(BuildContext context) {
    const CameraPosition _initialLocation = CameraPosition(
      target: LatLng(23.35125, 72.956),
      zoom: 17.0,
    );
    return GoogleMap(
      initialCameraPosition: _initialLocation,
      tiltGesturesEnabled: true,
      compassEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (controller) =>
          BlocProvider.of<UberMapCubit>(context)
              .mapController
              .complete(controller),
      myLocationEnabled: true,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      markers: Set<Marker>.of(markers.values),
      polylines:  Set<Polyline>.of(polylines.values),
    );
  }
}