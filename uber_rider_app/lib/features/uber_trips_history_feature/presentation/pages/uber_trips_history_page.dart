import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/getx/uber_trip_history_controller.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/widgets/uber_trip_history_tile.dart';
import 'package:uber_rider_app/injection_container.dart' as di;

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  final UberTripsHistoryController _uberTripsHistoryController =
      Get.put(di.sl<UberTripsHistoryController>());

  @override
  void initState() {
    _uberTripsHistoryController.getTripsHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Your Trips"),
        elevation: 0.0,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: !_uberTripsHistoryController.isTripLoaded.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _uberTripsHistoryController.tripsHistory.value.isEmpty
                  ? const Center(
                      child: Text("Trips Not Found!"),
                    )
                  : ListView.builder(
                      itemCount:
                          _uberTripsHistoryController.tripsHistory.value.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return TripHistoryTile(
                            tripHistoryEntity:
                                _uberTripsHistoryController.tripsHistory[index],
                            uberTripsHistoryController:
                                _uberTripsHistoryController,
                            index: index);
                      }),
        ),
      ),
    );
  }
}
