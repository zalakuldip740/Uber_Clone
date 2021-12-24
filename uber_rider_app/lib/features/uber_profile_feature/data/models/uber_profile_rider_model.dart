import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';

class RiderModel extends RiderEntity {
  @override
  const RiderModel(
      {String? name,
      String? email,
      int? phoneNumber,
      String? city,
      String? profileUrl,
      String? homeAddress,
      String? workAddress})
      : super(name, email, phoneNumber, city, profileUrl, homeAddress,
            workAddress);

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "mobile": phoneNumber,
      "city": city,
      "profile_img": profileUrl,
      "home_address": homeAddress,
      "work_address": workAddress
    };
  }

  factory RiderModel.fromMap(Map<String, dynamic>? data) {
    return RiderModel(
        name: data!['name'],
        city: data['city'],
        phoneNumber: data['mobile'],
        email: data['email'],
        workAddress: data['work_address'],
        homeAddress: data['home_address'],
        profileUrl: data['profile_img']);
  }
}
