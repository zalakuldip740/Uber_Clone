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
        decoration: const BoxDecoration(
            color: Color(0xfff7f6fb),
            borderRadius: BorderRadius.only(
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
                Text(
                  uberMapController.req_accepted_driver_and_vehicle_data["name"]
                      .toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 22),
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
                  uberMapController.req_accepted_driver_and_vehicle_data[
                          "vehicle_number_plate"]
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
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
                  uberMapController
                      .req_accepted_driver_and_vehicle_data["vehicle_model"]
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  uberMapController
                      .req_accepted_driver_and_vehicle_data["vehicle_company"]
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
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
