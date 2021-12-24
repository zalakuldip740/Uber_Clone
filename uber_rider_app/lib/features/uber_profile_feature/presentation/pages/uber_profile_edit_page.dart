import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';

class UberProfileEditPage extends StatefulWidget {
  final UberProfileController uberProfileController;

  const UberProfileEditPage({required this.uberProfileController, Key? key})
      : super(key: key);

  @override
  _UberProfileEditPageState createState() => _UberProfileEditPageState();
}

class _UberProfileEditPageState extends State<UberProfileEditPage> {
  final firstNameController = TextEditingController();
  final surNameController = TextEditingController();
  final emailController = TextEditingController();
  final homeAddressController = TextEditingController();
  final workAddressController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstNameController.dispose();
    surNameController.dispose();
    emailController.dispose();
    homeAddressController.dispose();
    workAddressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        //leading: FaIcon(FontAwesomeIcons.arrowLeft),
        title: const Text("Edit Account"),
        actions: [
          GestureDetector(
              onTap: () {
                widget.uberProfileController.updateRiderProfile(
                    firstNameController.text + " " + surNameController.text,
                    emailController.text,
                    cityController.text,
                    homeAddressController.text,
                    workAddressController.text);
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
                                    .uberProfileController.riderData!.profileUrl
                                    .toString()),
                                //FileImage(_profileImage!),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: GestureDetector(
                                    onTap: () {},
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
                              widget
                                  .uberProfileController.riderData!.phoneNumber
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
                              "Firstname",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              controller: firstNameController
                                ..text = widget
                                    .uberProfileController.riderData!.name!
                                    .split(" ")[0],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Surname",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              controller: surNameController
                                ..text = widget
                                    .uberProfileController.riderData!.name!
                                    .split(" ")[1],
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
                                ..text = widget
                                    .uberProfileController.riderData!.email!,
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
                                ..text = widget
                                    .uberProfileController.riderData!.city!,
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
                                ..text = widget.uberProfileController.riderData!
                                    .homeAddress!,
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
                                ..text = widget.uberProfileController.riderData!
                                    .workAddress!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
    );
  }
}
