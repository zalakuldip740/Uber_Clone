import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/getx/auth_controller.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/widgets/uber_auth_register_textfield_widget.dart';

class UberAuthRegistrationPage extends StatefulWidget {
  const UberAuthRegistrationPage({Key? key}) : super(key: key);

  @override
  _UberAuthRegistrationPageState createState() =>
      _UberAuthRegistrationPageState();
}

class _UberAuthRegistrationPageState extends State<UberAuthRegistrationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController workAddressController = TextEditingController();
  final UberAuthController _uberAuthController = Get.find();

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    emailController.dispose();
    homeAddressController.dispose();
    workAddressController.dispose();
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
                    Obx(
                      () => CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                            _uberAuthController.profileImgUrl.value),
                        //FileImage(_profileImage!),
                      ),
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
                buildStaticRegisterPageBody(
                    nameController,
                    emailController,
                    cityController,
                    homeAddressController,
                    workAddressController),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          cityController.text.isNotEmpty &&
                          homeAddressController.text.isNotEmpty &&
                          workAddressController.text.isNotEmpty &&
                          GetUtils.isEmail(emailController.text)) {
                        _uberAuthController.addRiderprofile(
                            nameController.text,
                            emailController.text,
                            cityController.text,
                            homeAddressController.text,
                            workAddressController.text);
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

Widget buildStaticRegisterPageBody(
    TextEditingController name,
    TextEditingController email,
    TextEditingController city,
    TextEditingController homeAddress,
    TextEditingController workAddress) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        child: const Text(
          "Let's start with creating your account",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      TextFieldWidget(
        labelText: 'Full Name',
        textType: 'Enter your name',
        inputType: TextInputType.text,
        controller: name,
      ),
      //Spacer(),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Email Address',
        textType: 'Enter your email',
        inputType: TextInputType.emailAddress,
        controller: email,
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'City',
        textType: 'Enter your city',
        inputType: TextInputType.streetAddress,
        controller: city,
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Home Address',
        textType: 'Enter your address',
        inputType: TextInputType.text,
        controller: homeAddress,
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Work Address',
        textType: 'Enter your work address',
        inputType: TextInputType.text,
        controller: workAddress,
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
