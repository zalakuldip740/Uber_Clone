import 'package:flutter/material.dart';

Widget textFieldOTP(
    {required TextEditingController textEditingController,
    required bool first,
    last,
    required BuildContext context}) {
  return SizedBox(
    height: 50,
    child: AspectRatio(
      aspectRatio: 0.8,
      child: TextField(
        controller: textEditingController,
        autofocus: true,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );
}
