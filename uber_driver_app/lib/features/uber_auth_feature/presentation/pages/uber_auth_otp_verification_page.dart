import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/getx/auth_controller.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/widgets/uber_auth_otp_page_top_body_widget.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/widgets/uber_auth_textfield_widget.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController code1 = TextEditingController();
  final TextEditingController code2 = TextEditingController();
  final TextEditingController code3 = TextEditingController();
  final TextEditingController code4 = TextEditingController();
  final TextEditingController code5 = TextEditingController();
  final TextEditingController code6 = TextEditingController();
  final UberAuthController _uberAuthController = Get.find();

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
              const SizedBox(
                height: 20,
              ),
              buildStaticOtpVerificationBody(),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        textFieldOTP(
                            first: true,
                            last: false,
                            context: context,
                            textEditingController: code1),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code2),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code3),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code4),
                        textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            textEditingController: code5),
                        textFieldOTP(
                            first: false,
                            last: true,
                            context: context,
                            textEditingController: code6),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String otp = code1.text +
                              code2.text +
                              code3.text +
                              code4.text +
                              code5.text +
                              code6.text;
                          _uberAuthController.verifyOtp(otp, context);
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              buildBottomOtpVerificationBody()
            ],
          ),
        ),
      ),
    );
  }
}
