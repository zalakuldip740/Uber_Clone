import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/pages/uber_map_live_tracking_page.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/getx/uber_trip_history_controller.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/widgets/rating_dialog_widget.dart';

class TripHistoryTile extends StatefulWidget {
  final TripHistoryEntity tripHistoryEntity;
  final int index;
  final UberTripsHistoryController uberTripsHistoryController;

  const TripHistoryTile(
      {required this.tripHistoryEntity,
      required this.uberTripsHistoryController,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  State<TripHistoryTile> createState() => _TripHistoryTileState();
}

class _TripHistoryTileState extends State<TripHistoryTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.tripHistoryEntity.isCompleted! &&
              widget.tripHistoryEntity.rating == 0.0
          ? 250.0
          : 200.0,
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (widget.tripHistoryEntity.isCompleted == false &&
                            widget.tripHistoryEntity.isArrived == true &&
                            widget.tripHistoryEntity.driverId != null) {
                          Get.to(() =>
                              UberMapLiveTrackingPage(index: widget.index));
                        }
                      },
                      child: widget.tripHistoryEntity.isCompleted == true
                          ? const Text('COMPLETED')
                          : widget.tripHistoryEntity.driverId != null &&
                                  widget.tripHistoryEntity.isArrived == true
                              ? const Text('ONGOING(TRACK)')
                              : widget.tripHistoryEntity.driverId == null
                                  ? const Text('CANCELLED')
                                  : const Text("WAITING"),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: widget.tripHistoryEntity.isCompleted!
                            ? MaterialStateProperty.all(Colors.green)
                            : widget.tripHistoryEntity.driverId != null &&
                                    widget.tripHistoryEntity.isArrived == true
                                ? MaterialStateProperty.all(Colors.orange)
                                : widget.tripHistoryEntity.driverId == null
                                    ? MaterialStateProperty.all(Colors.red)
                                    : MaterialStateProperty.all(
                                        Colors.blueAccent),
                      ),
                    ),
                    Row(
                      children: [
                        Text(DateFormat('dd-MM-yy hh:mm').format(DateTime.parse(
                            widget.tripHistoryEntity.tripDate!))),
                        const SizedBox(
                          width: 2,
                        ),
                        Visibility(
                          visible: widget.tripHistoryEntity.rating != 0,
                          child: Container(
                              width: 30,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.green[700],
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        widget.tripHistoryEntity.rating
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    const SizedBox(width: 1),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 10.0,
                                    )
                                  ])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  widget.tripHistoryEntity.source.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.my_location),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  widget.tripHistoryEntity.destination.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.location_on_sharp),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _iconWithTitle(
                      widget.tripHistoryEntity.travellingTime.toString(),
                      Icons.watch_later_outlined),
                  widget.tripHistoryEntity.driverId != null
                      ? _iconWithTitle(
                          " " + widget.tripHistoryEntity.driverName.toString(),
                          Icons.bike_scooter)
                      : _iconWithTitle("  --", Icons.bike_scooter),
                  _iconWithTitle(
                      "${widget.tripHistoryEntity.tripAmount}\u{20B9}",
                      Icons.credit_card_rounded),
                ],
              ),
            ),
            Visibility(
              visible: widget.tripHistoryEntity.isCompleted! &&
                  widget.tripHistoryEntity.rating == 0.0,
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showRatingAppDialog(context, widget.tripHistoryEntity,
                        widget.uberTripsHistoryController);
                  },
                  child: const Text('Rate Your Journey'),
                  style: ButtonStyle(
                    backgroundColor: widget.tripHistoryEntity.isCompleted!
                        ? MaterialStateProperty.all(Colors.green)
                        : MaterialStateProperty.all(Colors.orange),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWithTitle(String data, IconData iconData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(iconData),
        Text(
          data,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
