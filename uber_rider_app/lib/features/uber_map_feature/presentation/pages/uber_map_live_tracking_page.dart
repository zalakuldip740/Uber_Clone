import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:uber_rider_app/features/uber_map_feature/presentation/getx/uber_live_tracking_controller.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/widgets/uber_payment_bottom_sheet_widget.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/getx/uber_trip_history_controller.dart';
import 'package:uber_rider_app/injection_container.dart' as di;

class UberMapLiveTrackingPage extends StatefulWidget {
  final int index;

  const UberMapLiveTrackingPage({Key? key, required this.index})
      : super(key: key);

  @override
  _UberMapLiveTrackingPageState createState() =>
      _UberMapLiveTrackingPageState();
}

class _UberMapLiveTrackingPageState extends State<UberMapLiveTrackingPage> {
  final UberLiveTrackingController _uberLiveTrackingController =
      Get.put(di.sl<UberLiveTrackingController>());
  final UberTripsHistoryController _uberTripsHistoryController = Get.find();

  static const CameraPosition _defaultLocation = CameraPosition(
    target: LatLng(23.030357, 72.517845),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _uberLiveTrackingController.getDirectionData(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: true,
        body: _uberLiveTrackingController.isLoading.value
            ? Center(
                child: lottie.Lottie.network(
                    'https://assets9.lottiefiles.com/packages/lf20_ubozqrue.json'),
              )
            : Stack(
                children: [
                  GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      initialCameraPosition: _defaultLocation,
                      markers:
                          _uberLiveTrackingController.markers.value.toSet(),
                      polylines: {
                        Polyline(
                            polylineId: const PolylineId("polyLine"),
                            color: Colors.black,
                            width: 6,
                            jointType: JointType.round,
                            startCap: Cap.roundCap,
                            endCap: Cap.roundCap,
                            geodesic: true,
                            points: _uberLiveTrackingController
                                .polylineCoordinates.value),
                      },
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _uberLiveTrackingController.controller
                            .complete(controller);
                        CameraPosition liveLoc = CameraPosition(
                          target: LatLng(
                              _uberLiveTrackingController.liveLocLatitude.value,
                              _uberLiveTrackingController
                                  .liveLocLongitude.value),
                          zoom: 14.4746,
                        );
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(liveLoc));
                      }),
                  Positioned(
                    left: 10,
                    right: 10,
                    top: 55,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Text(
                                  _uberTripsHistoryController
                                      .tripsHistory.value[widget.index].source
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const FaIcon(FontAwesomeIcons.longArrowAltRight,
                                  color: Colors.white),
                              Flexible(
                                child: Text(
                                  _uberTripsHistoryController.tripsHistory
                                      .value[widget.index].destination
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Remaining :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              Text(
                                _uberLiveTrackingController
                                    .uberMapDirectionData.value[0].distanceText
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                _uberLiveTrackingController
                                    .uberMapDirectionData.value[0].durationText
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _uberLiveTrackingController
                            .isPaymentBottomSheetOpen.value &&
                        !_uberLiveTrackingController.isPaymentDone.value,
                    child: Positioned(
                        left: 15,
                        right: 15,
                        bottom: 0,
                        child: SizedBox(
                          height: 300,
                          child: UberPaymentBottomSheet(
                              tripHistoryEntity: _uberTripsHistoryController
                                  .tripsHistory.value[widget.index]),
                        )),
                  )
                ],
              ),
        floatingActionButton: Visibility(
          visible: !_uberLiveTrackingController.isPaymentBottomSheetOpen.value,
          child: GestureDetector(
            onTap: () {
              _uberLiveTrackingController.getDirectionData(widget.index);
            },
            child: Container(
                width: 120,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.black),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Icon(Icons.refresh, color: Colors.white),
                    Text(
                      "Refresh",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
