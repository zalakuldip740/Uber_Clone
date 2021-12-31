import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_rider_app/features/uber_profile_feature/domain/entities/uber_profile_rider_entity.dart';

class RiderModel extends RiderEntity {
  @override
  const RiderModel(
      {String? name,
      String? email,
      String? phoneNumber,
      String? city,
      String? profileUrl,
      String? homeAddress,
      String? workAddress,
      int? wallet})
      : super(name, email, phoneNumber, city, profileUrl, homeAddress,
            workAddress, wallet);

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "mobile": phoneNumber,
      "city": city,
      "profile_img": profileUrl,
      "home_address": homeAddress,
      "work_address": workAddress,
      "wallet": wallet,
    };
  }

  factory RiderModel.fromSnapShot(DocumentSnapshot documentSnapshot) {
    return RiderModel(
        name: documentSnapshot.get('name'),
        city: documentSnapshot.get('city'),
        phoneNumber: documentSnapshot.get('mobile'),
        email: documentSnapshot.get('email'),
        workAddress: documentSnapshot.get('work_address'),
        homeAddress: documentSnapshot.get('home_address'),
        profileUrl: documentSnapshot.get('profile_img'),
        wallet: documentSnapshot.get('wallet'));
  }
}
