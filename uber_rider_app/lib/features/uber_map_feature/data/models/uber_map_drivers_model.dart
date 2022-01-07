import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/entities/uber_map_get_drivers_entity.dart';

class DriverModel extends UberDriverEntity {
  const DriverModel(
      {final String? name,
      final bool? is_online,
      final DocumentReference? vehicle,
      final GeoPoint? currentLocation,
      final String? driverId,
      final String? mobile,
      final String? overall_rating,
      final String? profile_img})
      : super(
            name: name,
            driverId: driverId,
            vehicle: vehicle,
            currentLocation: currentLocation,
            is_online: is_online,
            overall_rating: overall_rating,
            mobile: mobile,
            profile_img: profile_img);

  factory DriverModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DriverModel(
      name: documentSnapshot.get('name'),
      vehicle: documentSnapshot.get('vehicle'),
      currentLocation: documentSnapshot.get('current_location'),
      is_online: documentSnapshot.get('is_online'),
      driverId: documentSnapshot.get('driver_id'),
      overall_rating: documentSnapshot.get('overall_rating'),
      mobile: documentSnapshot.get('mobile'),
      profile_img: documentSnapshot.get('profile_img'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "vehicle": vehicle,
      "current_location": currentLocation,
      "is_online": is_online,
      "driver_id": driverId,
      "overall_rating": overall_rating,
      "mobile": mobile,
      "profile_img": profile_img
    };
  }
}
