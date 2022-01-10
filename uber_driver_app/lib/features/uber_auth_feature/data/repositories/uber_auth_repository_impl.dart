
import 'package:uber_driver_app/features/uber_auth_feature/data/data_sources/uber_auth_data_source.dart';
import 'package:uber_driver_app/features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';

class UberAuthRepositoryImpl extends UberAuthRepository {
  final UberAuthDataSource uberAuthDataSource;
  UberAuthRepositoryImpl({required this.uberAuthDataSource});
  @override
  Future<bool> uberAuthIsSignIn() async {
    return await uberAuthDataSource.uberAuthIsSignIn();
  }

  @override
  Future<void> uberAuthPhoneVerification(String phoneNumber) async {
    return await uberAuthDataSource.uberAuthPhoneVerification(phoneNumber);
  }

  @override
  Future<void> uberAuthOtpVerification(String otp) async {
    return await uberAuthDataSource.uberAuthOtpVerification(otp);
  }

  @override
  Future<String> uberAuthGetUserUid() async {
    return await uberAuthDataSource.uberAuthGetUserUid();
  }

  @override
  Future<bool> uberAuthCheckUserStatus(String docId) async {
    return await uberAuthDataSource.uberAuthCheckUserStatus(docId);
  }

  @override
  Future<void> uberAuthSignOut() async {
    return await uberAuthDataSource.uberAuthSignOut();
  }

  @override
  Future<String> uberAddProfileImg(String driverId) async {
    return await uberAuthDataSource.uberAddProfileImg(driverId);
  }


}
