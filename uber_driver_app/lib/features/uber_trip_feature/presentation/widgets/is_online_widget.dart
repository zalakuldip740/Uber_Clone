import 'package:flutter/material.dart';

class IsOnlineWidget extends StatelessWidget {
  final String online;
  final Function() onPressed;

    const IsOnlineWidget({required this.online, required this.onPressed}) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 4),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(online,
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
