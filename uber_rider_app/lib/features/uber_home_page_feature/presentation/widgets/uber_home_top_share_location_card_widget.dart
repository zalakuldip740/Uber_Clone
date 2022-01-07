import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/getx/uber_home_controller.dart';

uberHomeTopShareLocationCardWidget(UberHomeController uberHomeController) {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Want Better",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white),
            ),
            const Text(
              "Pick-Ups ?",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                uberHomeController.getUserCurrentLocation();
              },
              child: Row(
                children: const [
                  Text(
                    "Share location  ",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  FaIcon(
                    FontAwesomeIcons.longArrowAltRight,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
        FaIcon(
          FontAwesomeIcons.binoculars,
          color: Colors.tealAccent.withOpacity(0.2),
          size: 75,
        ),
      ],
    ),
  );
}
