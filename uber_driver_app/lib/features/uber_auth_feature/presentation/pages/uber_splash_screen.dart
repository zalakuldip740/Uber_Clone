import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:uber_driver_app/core/internet/internet_cubit.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/getx/auth_controller.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/pages/uber_auth_register_page.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/pages/uber_auth_welcome_page.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/available_for_ride/user_req_cubit.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/driver_live_location/driver_location_cubit.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/cubit/uber_driver_map/uber_map_cubit.dart';
import 'package:uber_driver_app/features/uber_trip_feature/presentation/pages/home_page.dart';

import '/injection_container.dart' as di;

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
                builder: (context) => BlocProvider<DriverLocationCubit>(
                  create: (BuildContext context) =>
                      di.sl<DriverLocationCubit>(),
                  child: BlocProvider<UserReqCubit>(
                      create: (BuildContext context) => di.sl<UserReqCubit>(),
                      child: BlocProvider<UberMapCubit>(
                        create: (BuildContext context) => di.sl<UberMapCubit>(),
                        child: BlocProvider<InternetCubit>(
                          create: (BuildContext context) =>
                              di.sl<InternetCubit>(),
                          child: const HomePage(),
                        ),
                      )),
                ),
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
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 48),
          ),
          Icon(Icons.arrow_forward,size: 34,color: Colors.white,)
        ],
      )),
    );
  }
}
