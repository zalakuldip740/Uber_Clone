import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/getx/uber_home_controller.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/widgets/uber_home_custom_appbar_widget.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/widgets/uber_home_ride_options_widget.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/widgets/uber_home_top_share_location_card_widget.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/widgets/uber_home_where_to_widget.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/pages/map_with_source_destination_field.dart';
import 'package:uber_rider_app/injection_container.dart' as di;

class UberHomePage extends StatefulWidget {
  const UberHomePage({Key? key}) : super(key: key);

  @override
  _UberHomePageState createState() => _UberHomePageState();
}

class _UberHomePageState extends State<UberHomePage> {
  final UberHomeController _uberHomeController =
      Get.put(di.sl<UberHomeController>());

  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(23.030357, 72.517845),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _uberHomeController.getUserCurrentLocation();
  }

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
              uberHomeCustomAppBarWidget(),
              const SizedBox(
                height: 15,
              ),
              uberHomeTopShareLocationCardWidget(_uberHomeController),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Get.to(() => const MapWithSourceDestinationField(
                      newCameraPosition: _defaultLocation,
                      defaultCameraPosition: _defaultLocation));
                },
                child: uberHomeRiderOptionsWidget(),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Get.to(() => const MapWithSourceDestinationField(
                      newCameraPosition: _defaultLocation,
                      defaultCameraPosition: _defaultLocation));
                },
                child: UberHomeWhereToWidget(),
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
                  child: Obx(
                    () => Visibility(
                      visible: _uberHomeController.currentLat.value != 0.0,
                      child: GoogleMap(
                        onTap: (LatLng latLng) {
                          var currentLat = _uberHomeController.currentLat.value;
                          var currentLng = _uberHomeController.currentLng.value;
                          CameraPosition _newCameraPos = CameraPosition(
                            target: LatLng(currentLat, currentLng),
                            zoom: 14.4746,
                          );
                          Get.to(() => MapWithSourceDestinationField(
                              newCameraPosition: _newCameraPos,
                              defaultCameraPosition: _defaultLocation));
                        },
                        mapType: MapType.normal,
                        initialCameraPosition: _defaultLocation,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _uberHomeController.controller.complete(controller);
                          CameraPosition _newCameraPos = CameraPosition(
                            target: LatLng(_uberHomeController.currentLat.value,
                                _uberHomeController.currentLng.value),
                            zoom: 14.4746,
                          );
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(_newCameraPos));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
