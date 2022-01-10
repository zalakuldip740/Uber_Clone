import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class RiderEntity  extends Equatable{
  final String? city;
  final GeoPoint? current_location;
  final String? email;
  final String? home_address;
  final String? mobile;
  final String? name;
  final String? payment_method;
  final String? profile_img;
  final DocumentReference? wallet;
  final String? work_address;
  final String? rider_id;


  const RiderEntity(
      {
      this.city,
      this.current_location,
      this.email,
      this.home_address,
      this.mobile,
      this.name,
      this.payment_method,
      this.profile_img,
      this.wallet,
      this.work_address,
      this.rider_id});

  @override
  List<Object?> get props => [
    city,
    current_location,
    email,
    home_address,
    mobile,
    name,
    payment_method,
    profile_img,
    wallet,rider_id];
}
