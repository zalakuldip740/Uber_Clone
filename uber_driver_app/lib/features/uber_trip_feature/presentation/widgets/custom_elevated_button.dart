import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {

   const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key : key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:  onPressed,
      //arrived true and completed false -> ongoing
      child:  Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(Colors.black),
      ),
    );
  }
}