
import 'package:uber_driver_app/features/uber_auth_feature/domain/repositories/uber_auth_repository.dart';

class UberAuthCheckUserStatusUseCase {
  final UberAuthRepository uberAuthRepository;

  UberAuthCheckUserStatusUseCase({required this.uberAuthRepository});

  Future<bool> call(String docId) async {
    return await uberAuthRepository.uberAuthCheckUserStatus(docId);
  }
}
