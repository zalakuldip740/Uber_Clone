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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _uberTripsHistoryController.getTripsHistory();
    setUpScrollController();
    super.initState();
  }

  void setUpScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          _uberTripsHistoryController.getTripsHistory();
        }
      }
    });
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
                  : Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        ListView.builder(
                            controller: _scrollController,
                            itemCount: _uberTripsHistoryController
                                .tripsHistory.value.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return TripHistoryTile(
                                  tripHistoryEntity: _uberTripsHistoryController
                                      .tripsHistory[index],
                                  uberTripsHistoryController:
                                      _uberTripsHistoryController,
                                  index: index);
                            }),
                        Visibility(
                          visible:
                              _uberTripsHistoryController.isMoreLoading.value,
                          child: Positioned(
                              top: 10,
                              child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    backgroundColor: Colors.black,
                                  ))),
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}
