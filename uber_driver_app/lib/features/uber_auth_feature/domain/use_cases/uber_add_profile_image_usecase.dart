
import 'package:uber_driver_app/features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';

class UberAddProfileImgUseCase {
  final UberAuthRepository uberAuthRepository;

  UberAddProfileImgUseCase({required this.uberAuthRepository});

  Future<String> call(String driverId) async {
    return await uberAuthRepository.uberAddProfileImg(driverId);
  }
}
