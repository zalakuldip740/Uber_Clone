import 'package:flutter/material.dart';

class FunctionalButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;

     FunctionalButton({ required this.title, required this.icon, required this.onPressed})
      : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: onPressed,
          splashColor: Colors.black,
          fillColor: Colors.white,
          elevation: 15.0,
          shape: CircleBorder(),
          child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(
                icon,
                size: 30.0,
                color: Colors.black,
              )),
        ),
      ],
    );
  }

}