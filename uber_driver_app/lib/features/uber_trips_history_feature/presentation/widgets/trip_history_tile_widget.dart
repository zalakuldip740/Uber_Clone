import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/entities/trip_entity.dart';

class TripHistoryTile extends StatefulWidget {
  final TripEntity tripHistoryEntity;

  TripHistoryTile({required this.tripHistoryEntity, Key? key})
      : super(key: key);

  @override
  State<TripHistoryTile> createState() => _TripHistoryTileState();
}

class _TripHistoryTileState extends State<TripHistoryTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
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
                        debugPrint('Received click');
                      },
                      child: widget.tripHistoryEntity.tripHistoryModel
                                  .isCompleted ==
                              true
                          ? const Text('COMPLETED')
                          : widget.tripHistoryEntity.tripHistoryModel
                                      .isArrived ==
                                  true
                              ? const Text('ONGOING')
                              : const Text("WAITING"),
                      style: ButtonStyle(
                        backgroundColor: widget
                                .tripHistoryEntity.tripHistoryModel.isCompleted!
                            ? MaterialStateProperty.all(Colors.green)
                            : widget.tripHistoryEntity.tripHistoryModel
                                        .isArrived ==
                                    true
                                ? MaterialStateProperty.all(Colors.orange)
                                : MaterialStateProperty.all(Colors.blue),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(DateFormat('dd-MM-yy hh:mm').format(
                              DateTime.parse(widget.tripHistoryEntity
                                  .tripHistoryModel.tripDate!))),
                        ),
                        Visibility(
                          visible: widget
                                  .tripHistoryEntity.tripHistoryModel.rating !=
                              0,
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
                                        widget.tripHistoryEntity
                                            .tripHistoryModel.rating
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
                  widget.tripHistoryEntity.tripHistoryModel.source.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                leading: const Icon(Icons.my_location),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  widget.tripHistoryEntity.tripHistoryModel.destination
                      .toString(),
                  overflow: TextOverflow.ellipsis,
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
                      widget.tripHistoryEntity.tripHistoryModel.travellingTime
                          .toString(),
                      Icons.watch_later_outlined),
                  widget.tripHistoryEntity.riderModel != null
                      ? _iconWithTitle(
                          widget.tripHistoryEntity.riderModel.name!,
                          Icons.person)
                      : _iconWithTitle("rider", Icons.person),
                  _iconWithTitle(
                      "${widget.tripHistoryEntity.tripHistoryModel.tripAmount}",
                      FontAwesomeIcons.rupeeSign),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconWithTitle(String data, IconData iconData) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            iconData,
            size: 24,
          ),
        ),
        Text(
          data,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
