import 'package:uber_rider_app/features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';

class UberAddProfileImgUseCase {
  final UberAuthRepository uberAuthRepository;

  UberAddProfileImgUseCase({required this.uberAuthRepository});

  Future<String> call(String riderId) async {
    return await uberAuthRepository.uberAddProfileImg(riderId);
  }
}
