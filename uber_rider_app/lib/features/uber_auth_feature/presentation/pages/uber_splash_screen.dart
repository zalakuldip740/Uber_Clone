import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/getx/auth_controller.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/pages/uber_auth_register_page.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/pages/uber_auth_welcome_page.dart';
import 'package:uber_rider_app/features/uber_home_page_map_feature/presentation/pages/uber_home_page.dart';
import 'package:uber_rider_app/injection_container.dart' as di;

class UberSplashScreen extends StatefulWidget {
  const UberSplashScreen({Key? key}) : super(key: key);

  @override
  _UberSplashScreenState createState() => _UberSplashScreenState();
}

class _UberSplashScreenState extends State<UberSplashScreen> {
  final UberAuthController _uberAuthController =
      Get.put(di.sl<UberAuthController>());

  @override
  void initState() {
    _uberAuthController.checkIsSignIn();
    Timer(const Duration(seconds: 3), () async {
      if (_uberAuthController.isSignIn.value) {
        if (await _uberAuthController.checkUserStatus()) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const UberHomePage(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const UberAuthRegistrationPage(),
              ));
        }
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const UberAuthWelcomeScreen(),
            ));
      }
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
