import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationMap extends StatefulWidget {
  final CameraPosition defaultCameraPosition;
  final CameraPosition newCameraPosition;
  const CurrentLocationMap(
      {required this.defaultCameraPosition,
      required this.newCameraPosition,
      Key? key})
      : super(key: key);

  @override
  _CurrentLocationMapState createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    print(widget.newCameraPosition);
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: widget.defaultCameraPosition,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        controller.animateCamera(
            CameraUpdate.newCameraPosition(widget.newCameraPosition));
      },
    );
  }
}
