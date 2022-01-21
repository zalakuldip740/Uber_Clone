import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/uber_driver_map/uber_map_cubit.dart';

import 'functional_button.dart';

class GoogleMapWidget extends StatefulWidget {
  Map<MarkerId, Marker>? markers;
  Map<PolylineId, Polyline>? polylines;

  GoogleMapWidget(this.markers, this.polylines);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> mapController = Completer();

  @override
  Widget build(BuildContext context) {
    const CameraPosition _initialLocation = CameraPosition(
      target: LatLng(23.35125, 72.956),
      zoom: 17.0,
    );

    return Stack(
      children: [
        GoogleMap(
          tiltGesturesEnabled: true,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) =>
              mapController.complete(controller),
          myLocationEnabled: true,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: false,
          markers: Set<Marker>.of(widget.markers!.values),
          polylines: Set<Polyline>.of(widget.polylines!.values),
          initialCameraPosition: _initialLocation,
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FunctionalButton(
                  title: '',
                  icon: Icons.my_location,
                  onPressed: () {
                    BlocProvider.of<UberMapCubit>(context).getCurrentLocation(
                        context,
                        mapController: mapController);
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
