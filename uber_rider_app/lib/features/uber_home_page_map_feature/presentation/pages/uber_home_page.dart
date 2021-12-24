import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/presentation/cubit/uber_current_location_cubit.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/presentation/widgets/current_location_map.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/pages/map_with_source_destination_field.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/pages/uber_profile_page.dart';
import 'package:uber_rider_app/injection_container.dart' as di;

class UberHomePage extends StatefulWidget {
  const UberHomePage({Key? key}) : super(key: key);

  @override
  _UberHomePageState createState() => _UberHomePageState();
}

class _UberHomePageState extends State<UberHomePage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(23.030357, 72.517845),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Uber",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const UberProfilePage());
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.solidUserCircle,
                      size: 45,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Want Better",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        const Text(
                          "Pick-Ups ?",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            di
                                .sl<UberCurrentLocationCubit>()
                                .getUserCurrentLocation();
                          },
                          child: Row(
                            children: const [
                              Text(
                                "Share location  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              FaIcon(
                                FontAwesomeIcons.longArrowAltRight,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    FaIcon(
                      FontAwesomeIcons.binoculars,
                      color: Colors.tealAccent.withOpacity(0.2),
                      size: 75,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.grey[100]),
                    child: Column(
                      children: const [
                        FaIcon(FontAwesomeIcons.car),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "   Ride   ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.grey[100]),
                    child: Column(
                      children: const [
                        FaIcon(FontAwesomeIcons.car),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Rentals",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.grey[100]),
                    child: Column(
                      children: const [
                        FaIcon(FontAwesomeIcons.car),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Intercity",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MapWithSourceDestinationField(
                            defaultCameraPosition: _defaultLocation,
                            newCameraPosition: _defaultLocation,
                          )));
                },
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: Colors.grey[100]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Where to ?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.white),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.solidClock,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14)),
                            SizedBox(
                              width: 5,
                            ),
                            FaIcon(
                              FontAwesomeIcons.caretDown,
                              size: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[100]),
                  child: const FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
                title: const Text(
                  "Choose saved place",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Around You",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey[100]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: BlocBuilder<UberCurrentLocationCubit,
                      UberCurrentLocationState>(
                    builder: (context, state) {
                      if (state is UberCurrentLocationInitial) {
                        return const CurrentLocationMap(
                            defaultCameraPosition: _defaultLocation,
                            newCameraPosition: _defaultLocation);
                      } else if (state is UberCurrentLocationDeny) {
                        return const CurrentLocationMap(
                            defaultCameraPosition: _defaultLocation,
                            newCameraPosition: _defaultLocation);
                      } else if (state is UberCurrentLocationDenyForever) {
                        return const CurrentLocationMap(
                            defaultCameraPosition: _defaultLocation,
                            newCameraPosition: _defaultLocation);
                      } else if (state is UberCurrentLocationGranted) {
                        CameraPosition newLocation = CameraPosition(
                            target: LatLng(state.position.latitude,
                                state.position.longitude),
                            zoom: 10);
                        return GoogleMap(
                          onTap: (LatLng latLng) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MapWithSourceDestinationField(
                                      defaultCameraPosition: _defaultLocation,
                                      newCameraPosition: newLocation,
                                    )));
                          },
                          mapType: MapType.normal,
                          initialCameraPosition: _defaultLocation,
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(newLocation));
                          },
                        );
                      }
                      return const CurrentLocationMap(
                          defaultCameraPosition: _defaultLocation,
                          newCameraPosition: _defaultLocation);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
