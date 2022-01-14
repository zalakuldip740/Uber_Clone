import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/pages/uber_home_page.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/getx/uber_live_tracking_controller.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/widgets/uber_add_money_dialog_widget.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/getx/uber_trip_history_controller.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/presentation/widgets/rating_dialog_widget.dart';
import 'package:uber_rider_app/injection_container.dart' as di;

class UberPaymentBottomSheet extends StatefulWidget {
  final TripHistoryEntity tripHistoryEntity;

  const UberPaymentBottomSheet({required this.tripHistoryEntity, Key? key})
      : super(key: key);

  @override
  _UberPaymentBottomSheetState createState() => _UberPaymentBottomSheetState();
}

class _UberPaymentBottomSheetState extends State<UberPaymentBottomSheet> {
  final UberLiveTrackingController _uberLiveTrackingController =
      Get.put(di.sl<UberLiveTrackingController>());
  final UberTripsHistoryController _uberTripsHistoryController =
      Get.put(di.sl<UberTripsHistoryController>());
  final UberProfileController _uberProfileController =
      Get.put(di.sl<UberProfileController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Trip Completed",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15))),
                onPressed: () async {
                  String riderId = widget.tripHistoryEntity.riderId!.path
                      .split('/')
                      .last
                      .trim();
                  String driverId = widget.tripHistoryEntity.driverId!.path
                      .split('/')
                      .last
                      .trim();
                  int? tripAmount = widget.tripHistoryEntity.tripAmount;
                  String res = await _uberLiveTrackingController.makePayment(
                      riderId,
                      driverId,
                      tripAmount!,
                      widget.tripHistoryEntity.tripId.toString(),
                      "wallet");
                  if (res == "done") {
                    Get.off(() => const UberHomePage());
                    showRatingAppDialog(context, widget.tripHistoryEntity,
                        _uberTripsHistoryController);
                  } else {
                    Get.snackbar("Low balance!", "Pay via Cash or add money",
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 7),
                        mainButton: TextButton(
                            onPressed: () {
                              displayAddMoneyDialog(
                                  context, _uberProfileController);
                            },
                            child: const Text("Add Money")));
                  }
                },
                child: Text(
                  "Pay \u{20B9}${widget.tripHistoryEntity.tripAmount}",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "OR",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    elevation: MaterialStateProperty.all(0.0),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15))),
                onPressed: () async {
                  await _uberLiveTrackingController.makePayment("", "", 0,
                      widget.tripHistoryEntity.tripId.toString(), "cash");
                  Get.off(() => const UberHomePage());
                  //Get.back();
                  showRatingAppDialog(context, widget.tripHistoryEntity,
                      _uberTripsHistoryController);
                },
                child: Text(
                  "Pay \u{20B9}${widget.tripHistoryEntity.tripAmount} cash",
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
