import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/getx/auth_controller.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/widgets/uber_auth_register_page_body_widget.dart';

class UberAuthRegistrationPage extends StatefulWidget {
  const UberAuthRegistrationPage({Key? key}) : super(key: key);

  @override
  _UberAuthRegistrationPageState createState() =>
      _UberAuthRegistrationPageState();
}

class _UberAuthRegistrationPageState extends State<UberAuthRegistrationPage> {
  int selected_vehicle = 1;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController numberPlateController = TextEditingController();

  final UberAuthController _uberAuthController = Get.find();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cityController.dispose();
    companyController.dispose();
    modelController.dispose();
    numberPlateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          NetworkImage(_uberAuthController.profileImgUrl.value),
                      //FileImage(_profileImage!),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            _uberAuthController.pickProfileImg();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                ),
                uberRegisterPageBody(
                    nameController,
                    emailController,
                    cityController,
                    companyController,
                    modelController,
                    numberPlateController),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: selected_vehicle,
                            onChanged: (value) {
                              setState(() {
                                selected_vehicle = 1;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/bike.png",
                            scale: 8,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: selected_vehicle,
                            onChanged: (value) {
                              setState(() {
                                selected_vehicle = 2;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/auto.png",
                            scale: 5,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: selected_vehicle,
                            onChanged: (value) {
                              setState(() {
                                selected_vehicle = 3;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/car.png",
                            scale: 22,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          GetUtils.isEmail(emailController.text)) {
                        _uberAuthController.addDriverProfile(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            cityController.text.trim(),
                            selected_vehicle,
                            companyController.text.trim(),
                            modelController.text.trim(),
                            numberPlateController.text.trim(),
                            context);
                      } else {
                        Get.snackbar("error", "invalid values!");
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Create Account',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
