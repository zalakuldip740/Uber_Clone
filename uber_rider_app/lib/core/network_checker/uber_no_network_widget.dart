import 'package:flutter/material.dart';

class UberNoInterNetWidget extends StatelessWidget {
  const UberNoInterNetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/nonet.jpg'),
            const Text(
              "Please Check Your Connection!",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
