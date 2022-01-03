import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_add_profile_image_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_check_user_status_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_is_sign_in_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_otp_verification_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/domain/use_cases/uber_auth_phone_verification_usecase.dart';
import 'package:uber_rider_app/features/uber_auth_feature/presentation/pages/uber_auth_register_page.dart';
import 'package:uber_rider_app/features/uber_home_page_feature/presentation/pages/uber_home_page.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/use_cases/uber_profile_update_rider_usecase.dart';

class UberAuthController extends GetxController {
  final UberAuthIsSignInUseCase uberAuthIsSignInUseCase;
  final UberAuthPhoneVerificationUseCase uberAuthPhoneVerificationUseCase;
  final UberAuthOtpVerificationUseCase uberAuthOtpVerificationUseCase;
  final UberAuthCheckUserStatusUseCase uberAuthCheckUserStatusUseCase;
  final UberAuthGetUserUidUseCase uberAuthGetUserUidUseCase;
  final UberProfileUpdateRiderUsecase uberProfileUpdateRiderUsecase;
  final UberAddProfileImgUseCase uberAddProfileImgUseCase;
  var isSignIn = false.obs;
  var profileImgUrl =
      "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png"
          .obs;

  UberAuthController(
      {required this.uberAuthIsSignInUseCase,
      required this.uberAuthPhoneVerificationUseCase,
      required this.uberAuthOtpVerificationUseCase,
      required this.uberAuthCheckUserStatusUseCase,
      required this.uberAuthGetUserUidUseCase,
      required this.uberProfileUpdateRiderUsecase,
      required this.uberAddProfileImgUseCase});

  checkIsSignIn() async {
    bool uberAuthIsSignIn = await uberAuthIsSignInUseCase.call();
    isSignIn.value = uberAuthIsSignIn;
  }

  verifyPhoneNumber(String phoneNumber) async {
    await uberAuthPhoneVerificationUseCase.call(phoneNumber);
    Get.snackbar("Verifying Number", "Please wait !",
        showProgressIndicator: true, duration: const Duration(seconds: 10));
  }

  verifyOtp(String otp) async {
    Get.snackbar("Validating Otp", "Please wait !",
        showProgressIndicator: true, duration: const Duration(seconds: 10));
    await uberAuthOtpVerificationUseCase.call(otp).whenComplete(() async {
      String riderId = await uberAuthGetUserUidUseCase.call();
      if (riderId.isNotEmpty) {
        Get.closeAllSnackbars();
        final userStatus = await checkUserStatus();
        if (userStatus) {
          Get.offAll(() => const UberHomePage());
        } else {
          Get.offAll(() => const UberAuthRegistrationPage());
        }
      }
    });
  }

  Future<bool> checkUserStatus() async {
    String riderId = await uberAuthGetUserUidUseCase.call();
    return uberAuthCheckUserStatusUseCase.call(riderId);
  }

  pickProfileImg() async {
    String riderId = await uberAuthGetUserUidUseCase.call();
    String profileUrl = await uberAddProfileImgUseCase.call(riderId);
    Get.snackbar("please wait", "Uploading Image....");
    profileImgUrl.value = profileUrl;
  }

  addRiderprofile(String name, String email, String city, String homeAddress,
      String workAddress) async {
    final riderEntity = RiderEntity(
        name,
        email,
        FirebaseAuth.instance.currentUser!.phoneNumber,
        city,
        profileImgUrl.value,
        homeAddress,
        workAddress,
        0);
    await uberAuthGetUserUidUseCase.call().then((riderId) async {
      await uberProfileUpdateRiderUsecase.call(riderEntity, riderId);
      Get.snackbar("uploading details!", "Please wait !",
          showProgressIndicator: true, duration: const Duration(seconds: 10));
    });
    final userStatus = await checkUserStatus();
    if (userStatus) {
      Get.closeAllSnackbars();
      Get.snackbar("done", "registration successful!");
      Get.offAll(() => const UberHomePage());
    }
  }
}
