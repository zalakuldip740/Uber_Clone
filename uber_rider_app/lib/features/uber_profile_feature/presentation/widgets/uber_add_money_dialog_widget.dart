import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:uber_rider_app/features/uber_profile_feature/presentation/getx/uber_profile_controller.dart';

displayAddMoneyDialog(
    BuildContext context, UberProfileController uberProfileController) async {
  final _textFieldController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter amount between 100 to 9999'),
          content: TextField(
            controller: _textFieldController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "Enter amount"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add money'),
              onPressed: () {
                if (GetUtils.isLengthBetween(_textFieldController.text, 3, 4) &&
                    GetUtils.isNumericOnly(_textFieldController.text)) {
                  uberProfileController
                      .walletAddMoney(int.parse(_textFieldController.text));
                  Get.back();
                } else {
                  Get.snackbar("invalid input!", "Enter valid amount!");
                }
              },
            )
          ],
        );
      });
}
