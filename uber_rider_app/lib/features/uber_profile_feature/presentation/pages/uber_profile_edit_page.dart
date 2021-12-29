import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';

class UberProfileEditPage extends StatefulWidget {
  final UberProfileController uberProfileController;

  const UberProfileEditPage({required this.uberProfileController, Key? key})
      : super(key: key);

  @override
  _UberProfileEditPageState createState() => _UberProfileEditPageState();
}

class _UberProfileEditPageState extends State<UberProfileEditPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final homeAddressController = TextEditingController();
  final workAddressController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    homeAddressController.dispose();
    workAddressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          //leading: FaIcon(FontAwesomeIcons.arrowLeft),
          title: const Text("Edit Account"),
          actions: [
            GestureDetector(
                onTap: () {
                  if (nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      cityController.text.isNotEmpty &&
                      homeAddressController.text.isNotEmpty &&
                      workAddressController.text.isNotEmpty &&
                      GetUtils.isEmail(emailController.text)) {
                    widget.uberProfileController.updateRiderProfile(
                        nameController.text,
                        emailController.text,
                        cityController.text,
                        homeAddressController.text,
                        workAddressController.text);
                  } else {
                    Get.snackbar("error", "invalid values!");
                  }
                },
                child: const Icon(Icons.check)),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: !widget.uberProfileController.isLoaded.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage(widget
                                      .uberProfileController
                                      .riderData
                                      .value['profileUrl']
                                      .toString()),
                                  //FileImage(_profileImage!),
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.uberProfileController
                                            .pickProfileImg();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black),
                                        child: const Icon(
                                          Icons.edit_outlined,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                                widget.uberProfileController.riderData
                                    .value['phoneNumber']
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(),
                        Expanded(
                          child: ListView(
                            children: [
                              const Text(
                                "Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: nameController
                                  ..text = widget.uberProfileController
                                      .riderData.value['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: emailController
                                  ..text = widget.uberProfileController
                                      .riderData.value['email'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "City",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: cityController
                                  ..text = widget.uberProfileController
                                      .riderData.value['city'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Home Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: homeAddressController
                                  ..text = widget.uberProfileController
                                      .riderData.value['homeAddress'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Work Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.grey),
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: workAddressController
                                  ..text = widget.uberProfileController
                                      .riderData.value['workAddress'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
      ),
    );
  }
}
