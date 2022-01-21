import 'package:get/get.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_add_profile_image_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_sign_out_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/pages/uber_splash_screen.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_profile_get_rider_usecase.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_profile_update_rider_usecase.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_wallet_add_money_usecase.dart';

class UberProfileController extends GetxController {
  final UberProfileGetRiderProfileUsecase uberProfileGetRiderProfileUsecase;
  final UberProfileUpdateRiderUsecase uberProfileUpdateRiderUsecase;
  final UberAuthGetUserUidUseCase uberAuthGetUserUidUseCase;
  final UberAuthSignOutUseCase uberAuthSignOutUseCase;
  final UberAddProfileImgUseCase uberAddProfileImgUseCase;
  final UberWalletAddMoneyUsecase uberWalletAddMoneyUsecase;

  var riderData = {}.obs;
  var isLoaded = false.obs;

  UberProfileController(
      {required this.uberProfileGetRiderProfileUsecase,
      required this.uberProfileUpdateRiderUsecase,
      required this.uberAuthGetUserUidUseCase,
      required this.uberAuthSignOutUseCase,
      required this.uberAddProfileImgUseCase,
      required this.uberWalletAddMoneyUsecase});

  getRiderProfile() async {
    String riderId = await uberAuthGetUserUidUseCase.call();
    final riderProfileData = uberProfileGetRiderProfileUsecase.call(riderId);
    riderProfileData.listen((data) {
      riderData['name'] = data.name;
      riderData['phoneNumber'] = data.phoneNumber;
      riderData['email'] = data.email;
      riderData['city'] = data.city;
      riderData['homeAddress'] = data.homeAddress;
      riderData['workAddress'] = data.workAddress;
      riderData['profileUrl'] = data.profileUrl;
      riderData['wallet'] = data.wallet;
      isLoaded.value = true;
    });
  }

  pickProfileImg() async {
    String riderId = await uberAuthGetUserUidUseCase.call();
    String profileUrl = await uberAddProfileImgUseCase.call(riderId);
    Get.snackbar("please wait", "Uploading Image....",
        snackPosition: SnackPosition.BOTTOM);
    riderData['profileUrl'] = profileUrl;
  }

  updateRiderProfile(String name, String email, String city, String homeAddress,
      String workAddress) async {
    final riderEntity = RiderEntity(
        name,
        email,
        riderData.value['phoneNumber'],
        city,
        riderData['profileUrl'],
        homeAddress,
        workAddress,
        riderData.value['wallet']);
    String riderId = await uberAuthGetUserUidUseCase.call();
    await uberProfileUpdateRiderUsecase.call(riderEntity, riderId);
    Get.snackbar("Done.", "Profile Updated!",
        snackPosition: SnackPosition.BOTTOM);
  }

  signOut() async {
    await uberAuthSignOutUseCase.call();
    Get.snackbar('GoodBye..', "See you later.",
        snackPosition: SnackPosition.BOTTOM);
    Get.offAll(() => const UberSplashScreen());
  }

  walletAddMoney(int addAmt) async {
    String riderId = await uberAuthGetUserUidUseCase.call();
    await uberWalletAddMoneyUsecase.call(riderId, addAmt);
  }
}
