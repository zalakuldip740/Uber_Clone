import 'dart:io';

import 'package:get/get.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_profile_get_rider_usecase.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_profile_update_rider_usecase.dart';

class UberProfileController extends GetxController {
  final UberProfileGetRiderProfileUsecase uberProfileGetRiderProfileUsecase;
  final UberProfileUpdateRiderUsecase uberProfileUpdateRiderUsecase;

  String riderId = "PGujpKBGnNJPxbc0akYn";
  RiderEntity? riderData;
  var isLoaded = false.obs;

  UberProfileController(
      {required this.uberProfileGetRiderProfileUsecase,
      required this.uberProfileUpdateRiderUsecase});

  getRiderProfile() async {
    final riderProfileData =
        await uberProfileGetRiderProfileUsecase.call(riderId);
    riderData = riderProfileData;
    isLoaded.value = true;
  }

  updateRiderProfile(String name, String email, String city, String homeAddress,
      String workAddress) async {
    final riderEntity = RiderEntity(
        name,
        email,
        riderData!.phoneNumber,
        city,
        "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png",
        homeAddress,
        workAddress);
    try {
      await uberProfileUpdateRiderUsecase.call(riderEntity, riderId);
      Get.snackbar("Done", "Profile Updated!",
          snackPosition: SnackPosition.BOTTOM);
    } on SocketException {
      Get.snackbar("Error", "Something went wrong!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
