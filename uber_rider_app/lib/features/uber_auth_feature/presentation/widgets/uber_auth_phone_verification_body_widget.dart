import 'package:flutter/material.dart';

Widget buildStaticPhoneVerificationPageBody() {
  return Column(
    children: [
      const SizedBox(
        height: 8,
      ),
      Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/mobile_auth_img.png',
        ),
      ),
      const SizedBox(
        height: 24,
      ),
      const Text(
        'Verification',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Add your phone number. we'll send you a verification code so we can identify it's you.",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black38,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 28,
      ),
    ],
  );
}
