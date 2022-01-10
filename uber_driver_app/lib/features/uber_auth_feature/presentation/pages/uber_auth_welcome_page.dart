import 'package:flutter/material.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/widgets/uber_auth_welcome_page_body_widget.dart';

class UberAuthWelcomeScreen extends StatefulWidget {
  const UberAuthWelcomeScreen({Key? key}) : super(key: key);

  @override
  _UberAuthWelcomeScreen createState() => _UberAuthWelcomeScreen();
}

class _UberAuthWelcomeScreen extends State<UberAuthWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              uberAuthTopWelcomeScreenBody(),
              const SizedBox(
                height: 22,
              ),
              uberAuthLoginButton()
            ],
          ),
        ),
      ),
    );
  }
}
