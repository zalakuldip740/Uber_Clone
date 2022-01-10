import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:uber_driver_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';
import 'package:uber_driver_app/features/uber_profile_feature/presentation/pages/uber_profile_edit_page.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/presentation/cubit/trip_history_cubit.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/presentation/pages/trip_history_page.dart';

import '/injection_container.dart' as di;

class UberProfilePage extends StatefulWidget {
  const UberProfilePage({Key? key}) : super(key: key);

  @override
  _UberProfilePageState createState() => _UberProfilePageState();
}

class _UberProfilePageState extends State<UberProfilePage> {
  final UberProfileController _uberProfileController =
      Get.put(di.sl<UberProfileController>());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _uberProfileController.getDriverProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.close,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => ListTile(
                title: _uberProfileController.isLoaded.value
                    ? Text(
                        _uberProfileController.driverData.value['name']
                            .toString(),
                        style: const TextStyle(fontSize: 30),
                      )
                    : const Text("Loading Profile..."),
                trailing: GestureDetector(
                  onTap: () {
                    Get.to(() => UberProfileEditPage(
                        uberProfileController: _uberProfileController));
                  },
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(_uberProfileController
                        .driverData.value['profile_img']
                        .toString()),
                  ),
                ),
                subtitle: Row(
                  children:  [
                    const FaIcon(
                      FontAwesomeIcons.solidStar,
                      size: 12,
                      color: Colors.black45,
                    ),
                    Text(
                    _uberProfileController.driverData.value["overall_rating"].toString() ,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            color: Colors.grey[100]),
                        child: Column(
                          children: const [
                            FaIcon(FontAwesomeIcons.hireAHelper),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              " Help ",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            color: Colors.grey[100]),
                        child: Column(
                          children: const [
                            FaIcon(FontAwesomeIcons.wallet),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Wallet",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider<TripHistoryCubit>(
                                  create: (BuildContext context) =>
                                      di.sl<TripHistoryCubit>(),
                                  child: const TripHistory()
                                ),
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              color: Colors.grey[100]),
                          child: Column(
                            children: const [
                              FaIcon(FontAwesomeIcons.solidClock),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                " Trips ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          color: Colors.grey[100]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Wallet Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Text(
                              "₹${_uberProfileController.driverData.value['wallet']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 22)),

                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 8,
                    color: Colors.grey[100],
                  ),
                  const ListTile(
                    leading: FaIcon(FontAwesomeIcons.mailBulk),
                    title: Text("Messages",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  const ListTile(
                    leading: FaIcon(FontAwesomeIcons.gift),
                    title: Text("Send a Gift",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  const ListTile(
                    leading: FaIcon(FontAwesomeIcons.userAstronaut),
                    title: Text("Drive or Deliver with Uber",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  const ListTile(
                    leading: Icon(Icons.error),
                    title: Text("Legal",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  ListTile(
                    onTap: () {
                      _uberProfileController.signOut();
                    },
                    leading: const FaIcon(FontAwesomeIcons.signOutAlt),
                    title: const Text("Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "V.1.0",
                      style: TextStyle(
                          color: Colors.grey[400], fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
