import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_driver_app/config/maps_api_key.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/available_for_ride/user_req_cubit.dart';

part 'uber_map_state.dart';

class UberMapCubit extends Cubit<UberMapState> {
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  bool isPolyLineDrawn = false;

  late double _source_lat;
  late double _source_long;
  late double _current_lat;
  late double _current_long;
  late double _destination_lat;
  late double _destination_long;

  late GoogleMapController controller;

  UberMapCubit() : super(UberMapInitial());

  //method for drawing route of accepted trip
  void drawRoute(UserReqDisplayOne state, BuildContext context) async {
    if (isPolyLineDrawn == false) {

      emit(UberMapLoading());

      _source_lat = state.tripDriver.tripHistoryModel.sourceLocation!.latitude;
      _source_long =
          state.tripDriver.tripHistoryModel.sourceLocation!.longitude;
      _destination_lat =
          state.tripDriver.tripHistoryModel.destinationLocation!.latitude;
      _destination_long =
          state.tripDriver.tripHistoryModel.destinationLocation!.longitude;

      //for way point
      String pickup_point = state.tripDriver.tripHistoryModel.source.toString();

      /// source location/pickup point marker

      MarkerId markerId = const MarkerId("pickupPoint");
      Marker source_marker = Marker(
          markerId: markerId,
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(
            _source_lat,
            _source_long,
          ),
          infoWindow: const InfoWindow(title: "Pickup Point"));
      markers[markerId] = source_marker;

      /// destination marker
      MarkerId markerDestId = const MarkerId("destPoint");
      Marker dest_marker = Marker(
          markerId: markerDestId,
          icon: BitmapDescriptor.defaultMarkerWithHue(90),
          position: LatLng(_destination_lat, _destination_long),
          infoWindow: const InfoWindow(title: "Destination"));

      ///add marker to markers list
      markers[markerDestId] = dest_marker;

      //get current location for drawing root
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        _current_lat = position.latitude;
        _current_long = position.longitude;
      }).catchError((e) {
        print(e);
      });
      _getPolyline(_current_lat, _current_long, _destination_lat,
          _destination_long, pickup_point);
    } else {
      print("route is already drawn.");
    }
  }

  _getPolyline(double source_lat, double source_long, double dest_lat,
      double dest_long, String pickup_point) async {

    emit(UberMapLoading());
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(source_lat, source_long),
        PointLatLng(dest_lat, dest_long),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: pickup_point)]);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      _addPolyLine();
    }
  }

  _addPolyLine() {

    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 5);
    polylines[id] = polyline;
    isPolyLineDrawn = true;
    emit(UberMapLoaded(polylines: polylines, markers: markers));
  }

  resetMapForNewRide(BuildContext context) async {
    if (state is UberMapLoaded) {
      isPolyLineDrawn = false;
      polylineCoordinates.clear();
      emit(UberMapInitial());
    }

  }

  // Method for retrieving the current location
  getCurrentLocation(BuildContext context,
      {required Completer<GoogleMapController> mapController}) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Alert",
          "Location permissions are denied",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Alert",
          "Location permissions are permanently denied,please enable it from app setting",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {

      controller = await mapController.future;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        //   location_controller.changePosition(position, controller, context);
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      }).catchError((e) {
        print(e);
      });
    } else {
      Get.snackbar(
        "Alert",
        "Location permissions are permanently denied,please enable it from app setting",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
