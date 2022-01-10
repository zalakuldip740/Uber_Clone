import 'package:flutter/cupertino.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/widgets/uber_auth_register_textfield_widget.dart';

Widget uberRegisterPageBody(
    TextEditingController name,
    TextEditingController email,
    TextEditingController city,
    TextEditingController company,
    TextEditingController model,
    TextEditingController number_plate) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        child: const Text(
          "Let's start with creating your account",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      TextFieldWidget(
        labelText: 'Full Name*',
        textType: 'Enter your name',
        inputType: TextInputType.text,
        controller: name,
      ),
      //Spacer(),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Email Address',
        textType: 'Enter your email',
        inputType: TextInputType.emailAddress,
        controller: email,
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'City*',
        textType: 'Enter your current city',
        inputType: TextInputType.text,
        controller: city,
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Vehicle Company*',
        textType: 'Enter Company name',
        inputType: TextInputType.text,
        controller: company,
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Vehicle Model*',
        textType: 'Enter your vehicle model name',
        inputType: TextInputType.text,
        controller: model,
      ),
      const SizedBox(
        height: 10,
      ),
      TextFieldWidget(
        labelText: 'Number Plate*',
        textType: 'Enter your vehicle Number plate',
        inputType: TextInputType.text,
        controller: number_plate,
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
