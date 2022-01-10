
import 'package:uber_driver_app/features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';

class UberAuthOtpVerificationUseCase {
  final UberAuthRepository uberAuthRepository;

  UberAuthOtpVerificationUseCase({required this.uberAuthRepository});

  Future<void> call(String otp) async {
    return await uberAuthRepository.uberAuthOtpVerification(otp);
  }
}
