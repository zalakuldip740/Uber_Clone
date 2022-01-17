import 'package:flutter/cupertino.dart';
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
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(uberMapController
                      .req_accepted_driver_and_vehicle_data["profile_img"]
                      .toString()),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uberMapController
                          .req_accepted_driver_and_vehicle_data["name"]
                          .toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      uberMapController.req_accepted_driver_and_vehicle_data[
                                  "overall_rating"]
                              .toString() +
                          " ⭐",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.blueAccent),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    String mobile = uberMapController
                        .req_accepted_driver_and_vehicle_data["mobile"]
                        .toString();
                    await FlutterPhoneDirectCaller.callNumber(mobile);
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.call),
                  ),
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
                  uberMapController.req_accepted_driver_and_vehicle_data[
                          "vehicle_number_plate"]
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "color :" +
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
                  "model :" +
                      uberMapController
                          .req_accepted_driver_and_vehicle_data["vehicle_model"]
                          .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  "company :" +
                      uberMapController.req_accepted_driver_and_vehicle_data[
                              "vehicle_company"]
                          .toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
