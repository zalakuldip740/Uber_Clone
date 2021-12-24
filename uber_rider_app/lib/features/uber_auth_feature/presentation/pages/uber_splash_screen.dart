import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/presentation/pages/uber_home_page.dart';

class UberSplashScreen extends StatefulWidget {
  const UberSplashScreen({Key? key}) : super(key: key);

  @override
  _UberSplashScreenState createState() => _UberSplashScreenState();
}

class _UberSplashScreenState extends State<UberSplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const UberHomePage(),
          ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Uber",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 45),
          ),
          FaIcon(
            FontAwesomeIcons.longArrowAltRight,
            color: Colors.white,
            size: 45,
          )
        ],
      )),
    );
  }
}
