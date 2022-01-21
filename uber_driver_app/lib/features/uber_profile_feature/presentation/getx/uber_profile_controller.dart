import 'package:get/get.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/use_cases/uber_add_profile_image_usecase.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/use_cases/uber_auth_get_user_uid_usecase.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/use_cases/uber_auth_sign_out_usecase.dart';
import 'package:uber_driver_app/features/uber_auth_feature/presentation/pages/uber_splash_screen.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/driver_entity.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/use_cases/uber_profile_get_driver_usecase.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/use_cases/uber_profile_update_driver_usecase.dart';

class UberProfileController extends GetxController {
  final UberProfileGetDriverProfileUsecase uberProfileGetRiderProfileUsecase;
  final UberProfileUpdateDriverUsecase uberProfileUpdateDriverUsecase;
  final UberAuthGetUserUidUseCase uberAuthGetUserUidUseCase;
  final UberAuthSignOutUseCase uberAuthSignOutUseCase;
  final UberAddProfileImgUseCase uberAddProfileImgUseCase;

  var driverData = {}.obs;
  var isLoaded = false.obs;
  late DriverEntity driverEntity;

  UberProfileController({
    required this.uberProfileGetRiderProfileUsecase,
    required this.uberProfileUpdateDriverUsecase,
    required this.uberAuthGetUserUidUseCase,
    required this.uberAuthSignOutUseCase,
    required this.uberAddProfileImgUseCase,
  });

  getDriverProfile() async {
    String driverId = await uberAuthGetUserUidUseCase.call();
    final driverProfileData = uberProfileGetRiderProfileUsecase.call(driverId);
    driverProfileData.listen((data) {
      driverEntity = data;
      driverData['name'] = data.name;
      driverData['mobile'] = data.mobile;
      driverData['email'] = data.email;
      driverData['profile_img'] = data.profile_img;
      driverData['wallet'] = data.wallet;
      driverData['overall_rating'] = data.overall_rating;
      driverData['city'] = data.city;
      isLoaded.value = true;
    });
  }

  pickProfileImg() async {
    String driverId = await uberAuthGetUserUidUseCase.call();
    String profileUrl = await uberAddProfileImgUseCase.call(driverId);
    Get.snackbar("please wait", "Uploading Image....",
        snackPosition: SnackPosition.BOTTOM);
    driverData['profile_img'] = profileUrl;
  }

  updateDriverProfile(String name, String email) async {
    final driver = DriverEntity(
        name: name,
        email: email,
        profile_img: driverData['profile_img'],
        mobile: driverEntity.mobile,
        wallet: driverEntity.wallet,
        current_location: driverEntity.current_location,
        driver_id: driverEntity.driver_id,
        is_online: driverEntity.is_online,
        overall_rating: driverEntity.overall_rating,
        vehicle: driverEntity.vehicle,
        city: driverEntity.city);
    String driverId = await uberAuthGetUserUidUseCase.call();
    await uberProfileUpdateDriverUsecase.call(driver, driverId);
    Get.snackbar("Done", "Profile Updated!",
        snackPosition: SnackPosition.BOTTOM);
  }

  signOut() async {
    await uberAuthSignOutUseCase.call();
    Get.snackbar("Good Bye..", "Come Back Later!!",
        snackPosition: SnackPosition.BOTTOM);
    Get.offAll(() => const UberSplashScreen());
  }
}
