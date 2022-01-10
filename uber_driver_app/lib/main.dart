import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/pages/uber_splash_screen.dart';

import 'core/internet/internet_cubit.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Uber Driver',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<InternetCubit>(
        create: (BuildContext context) => di.sl<InternetCubit>(),
        child: const UberSplashScreen(),
      ),
    );
  }
}
