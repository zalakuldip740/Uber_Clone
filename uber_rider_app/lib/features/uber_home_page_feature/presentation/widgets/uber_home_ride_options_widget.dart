import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

uberHomeRiderOptionsWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey[100]),
        child: Column(
          children: const [
            FaIcon(FontAwesomeIcons.car),
            SizedBox(
              height: 5,
            ),
            Text(
              "   Ride   ",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey[100]),
        child: Column(
          children: const [
            FaIcon(FontAwesomeIcons.car),
            SizedBox(
              height: 5,
            ),
            Text(
              "Rentals",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey[100]),
        child: Column(
          children: const [
            FaIcon(FontAwesomeIcons.car),
            SizedBox(
              height: 5,
            ),
            Text(
              "Intercity",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ],
  );
}
