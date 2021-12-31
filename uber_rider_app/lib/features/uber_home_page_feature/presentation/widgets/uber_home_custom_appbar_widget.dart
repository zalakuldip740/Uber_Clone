import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/pages/uber_profile_page.dart';

uberHomeCustomAppBarWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Uber",
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
      ),
      GestureDetector(
        onTap: () {
          Get.to(() => const UberProfilePage());
        },
        child: const FaIcon(
          FontAwesomeIcons.solidUserCircle,
          size: 45,
        ),
      )
    ],
  );
}
