import 'package:flutter/material.dart';

uberHomeRiderOptionsWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey[100]),
        child: Column(
          children: [
            //FaIcon(FontAwesomeIcons.car),
            Image.asset(
              "assets/home_car.png",
              width: 80,
              height: 80,
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            const Text(
              "   Ride   ",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey[100]),
        child: Column(
          children: [
            Image.asset(
              "assets/home_car.png",
              width: 80,
              height: 80,
            ),
            //FaIcon(FontAwesomeIcons.car),
            // const SizedBox(
            //   height: 5,
            // ),
            const Text(
              "Rentals",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Colors.grey[100]),
        child: Column(
          children: [
            Image.asset(
              "assets/home_car.png",
              width: 80,
              height: 80,
            ),
            // FaIcon(FontAwesomeIcons.car),
            // const SizedBox(
            //   height: 5,
            // ),
            const Text(
              "Intercity",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    ],
  );
}
