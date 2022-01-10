import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/pages/uber_auth_phone_verification_page.dart';

Widget uberAuthTopWelcomeScreenBody() {
  return Column(
    children: [
      Image.asset(
        'assets/welcome_img.png',
        width: 240,
      ),
      const SizedBox(
        height: 18,
      ),
      const Text(
        "Let's get started",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Expand Your Travel Experience with Uber.",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black38,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 38,
      ),
    ],
  );
}

Widget uberAuthLoginButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        Get.to(() => const PhoneVerificationPage());
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14.0),
        child: Text(
          'Get Started',
          style: TextStyle(fontSize: 16),
        ),
      ),
    ),
  );
}
