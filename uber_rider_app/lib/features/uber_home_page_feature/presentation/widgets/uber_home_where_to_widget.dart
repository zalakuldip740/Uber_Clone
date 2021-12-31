import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

UberHomeWhereToWidget() {
  return Container(
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: Colors.grey[100]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Where to ?",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              FaIcon(
                FontAwesomeIcons.solidClock,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Now",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              SizedBox(
                width: 5,
              ),
              FaIcon(
                FontAwesomeIcons.caretDown,
                size: 15,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
