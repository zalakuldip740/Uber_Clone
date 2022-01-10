
import 'package:uber_driver_app/features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';

class UberAuthPhoneVerificationUseCase {
  final UberAuthRepository uberAuthRepository;

  UberAuthPhoneVerificationUseCase({required this.uberAuthRepository});

  Future<void> call(String phoneNumber) async {
    return await uberAuthRepository.uberAuthPhoneVerification(phoneNumber);
  }
}
