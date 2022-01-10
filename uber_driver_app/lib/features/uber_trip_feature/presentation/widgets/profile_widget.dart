import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final Function() onPressed;
  final String imgUrl;

   ProfileWidget({ required this.onPressed, required this.imgUrl}) : super();


  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
          ],
        ),
        child: ClipOval(
          child: Image.network(
            imgUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
