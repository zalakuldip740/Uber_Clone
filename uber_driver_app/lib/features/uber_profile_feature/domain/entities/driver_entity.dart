
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DriverEntity  extends Equatable{
  final String? name;
  final String? email;
  final bool? is_online;
  final String? mobile;
  final String? overall_rating;
  final String? profile_img;
  final int? wallet;
  final DocumentReference? vehicle;
  final GeoPoint? current_location;
  final String? driver_id;
  final String? city;


  const DriverEntity(
      { this.city,
        this.name,
        this.email,
        this.is_online,
        this.mobile,
        this.overall_rating,
        this.profile_img,
        this.wallet,
        this.vehicle,
        this.current_location,
        this.driver_id });

  @override
  List<Object?> get props => [name,
    email,
    is_online,
    mobile,
    overall_rating,
    profile_img,
    wallet,
    vehicle,
    current_location,driver_id,city];
}
