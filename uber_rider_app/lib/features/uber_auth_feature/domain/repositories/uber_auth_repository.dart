abstract class UberAuthRepository {
  Future<bool> uberAuthIsSignIn();

  Future<void> uberAuthPhoneVerification(String phoneNumber);

  Future<void> uberAuthOtpVerification(String otp);

  Future<String> uberAuthGetUserUid();

  Future<bool> uberAuthCheckUserStatus(String docId);

  Future<void> uberAuthSignOut();

  Future<String> uberAddProfileImg(String riderId);
}
