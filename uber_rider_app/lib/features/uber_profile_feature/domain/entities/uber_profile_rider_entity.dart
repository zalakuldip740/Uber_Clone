import 'package:equatable/equatable.dart';

class RiderEntity extends Equatable {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? profileUrl;
  final String? homeAddress;
  final String? workAddress;
  final int? wallet;

  const RiderEntity(this.name, this.email, this.phoneNumber, this.city,
      this.profileUrl, this.homeAddress, this.workAddress, this.wallet);

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        city,
        profileUrl,
        homeAddress,
        workAddress,
        wallet
      ];
}
