import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uber_rider_app/features/uber_map_feature/presentation/getx/uber_map_controller.dart';

class DriverDetails extends StatelessWidget {
  final UberMapController uberMapController;

  const DriverDetails({required this.uberMapController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(uberMapController
                      .req_accepted_driver_and_vehicle_data["profile_img"]
                      .toString()),
                ),
                const Text(
                  "Driver Name : Vivek",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "number :" +
                      uberMapController.req_accepted_driver_and_vehicle_data[
                              "vehicle_number_plate"]
                          .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "vehicle color :" +
                      uberMapController
                          .req_accepted_driver_and_vehicle_data["vehicle_color"]
                          .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "vehicle model :" +
                      uberMapController
                          .req_accepted_driver_and_vehicle_data["vehicle_model"]
                          .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "manu.company :" +
                      uberMapController.req_accepted_driver_and_vehicle_data[
                              "vehicle_company"]
                          .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  String mobile = uberMapController
                      .req_accepted_driver_and_vehicle_data["mobile"]
                      .toString();
                  await FlutterPhoneDirectCaller.callNumber(mobile);
                },
                icon: const Icon(Icons.call),
                label: const Text("Call Driver"))
          ],
        ),
      ),
    );
  }
}
