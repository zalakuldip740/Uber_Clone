import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UberDriverEntity extends Equatable {
  final String? name;
  final String? email;
  final bool? is_online;
  final String? mobile;
  final String? overall_rating;
  final String? profile_img;
  final String? total_trips;
  final DocumentReference? wallet;
  final DocumentReference? vehicle;
  final GeoPoint? currentLocation;
  final String? driverId;

  const UberDriverEntity(
      {this.name,
      this.email,
      this.is_online,
      this.mobile,
      this.overall_rating,
      this.profile_img,
      this.total_trips,
      this.wallet,
      this.vehicle,
      this.currentLocation,
      this.driverId});

  @override
  List<Object?> get props => [
        name,
        email,
        is_online,
        mobile,
        overall_rating,
        profile_img,
        total_trips,
        wallet,
        vehicle,
        currentLocation,
        driverId
      ];
}
