import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/pages/uber_map_live_tracking_page.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/widgets/uber_payment_bottom_sheet_widget.dart';
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
  final UberTripsHistoryController _uberTripsHistoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.tripHistoryEntity.isCompleted! &&
              widget.tripHistoryEntity.isPaymentDone! &&
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
                      onPressed: () {},
                      child: widget.tripHistoryEntity.isCompleted == true
                          ? const Text('COMPLETED')
                          : widget.tripHistoryEntity.isArrived == true
                              ? const Text('ONGOING')
                              : widget.tripHistoryEntity.readyForTrip == true
                                  ? const Text("WAITING")
                                  : const Text('CANCELLED'),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: widget.tripHistoryEntity.isCompleted!
                            ? MaterialStateProperty.all(Colors.green)
                            : widget.tripHistoryEntity.isArrived == true
                                ? MaterialStateProperty.all(Colors.orange)
                                : widget.tripHistoryEntity.readyForTrip == true
                                    ? MaterialStateProperty.all(
                                        Colors.blueAccent)
                                    : MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                    if (!widget.tripHistoryEntity.isArrived! &&
                        widget.tripHistoryEntity.readyForTrip!)
                      GestureDetector(
                        onTap: () async {
                          String driverId = widget
                              .tripHistoryEntity.driverId!.path
                              .split("/")
                              .last
                              .trim();
                          String mobile = _uberTripsHistoryController
                              .tripDrivers[driverId]!.mobile
                              .toString();
                          await FlutterPhoneDirectCaller.callNumber(mobile);
                        },
                        child: const Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                      ),
                    if (widget.tripHistoryEntity.isArrived! &&
                        !widget.tripHistoryEntity.isCompleted!)
                      GestureDetector(
                        onTap: () {
                          Get.to(() =>
                              UberMapLiveTrackingPage(index: widget.index));
                        },
                        child: const Text(
                          "Track",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    if (widget.tripHistoryEntity.isCompleted! &&
                        !widget.tripHistoryEntity.isPaymentDone!)
                      ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0.0)),
                          onPressed: () {
                            Get.bottomSheet(
                                SizedBox(
                                    height: 300,
                                    child: UberPaymentBottomSheet(
                                        tripHistoryEntity:
                                            _uberTripsHistoryController
                                                .tripsHistory
                                                .value[widget.index])),
                                isDismissible: false,
                                enableDrag: false);
                          },
                          child: const Text("Pay")),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _iconWithTitle(
                      widget.tripHistoryEntity.travellingTime.toString(),
                      Icons.watch_later_outlined),
                  widget.tripHistoryEntity.driverId != null
                      ? _iconWithTitle(
                          " " +
                              widget
                                  .uberTripsHistoryController
                                  .tripDrivers
                                  .value[widget.tripHistoryEntity.driverId!.path
                                      .split("/")
                                      .last
                                      .trim()]!
                                  .name
                                  .toString(),
                          FontAwesomeIcons.car)
                      : _iconWithTitle("  --", FontAwesomeIcons.car),
                  _iconWithTitle("${widget.tripHistoryEntity.tripAmount}",
                      FontAwesomeIcons.rupeeSign),
                ],
              ),
            ),
            Visibility(
              visible: widget.tripHistoryEntity.isCompleted! &&
                  widget.tripHistoryEntity.isPaymentDone! &&
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
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              iconData,
              size: 24,
            ),
          ),
          Flexible(
            child: Text(
              data,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
