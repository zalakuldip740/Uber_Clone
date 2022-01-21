import 'package:uber_rider_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberWalletAddMoneyUsecase {
  final UberProfileRepository uberProfileRepository;

  UberWalletAddMoneyUsecase({required this.uberProfileRepository});

  Future<void> call(String riderId, int addAmt) async {
    return await uberProfileRepository.walletAddMoney(riderId, addAmt);
  }
}
