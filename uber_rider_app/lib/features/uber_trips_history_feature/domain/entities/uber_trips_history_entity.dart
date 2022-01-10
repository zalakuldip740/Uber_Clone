import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TripHistoryEntity extends Equatable {
  final String? source;
  final String? destination;
  final GeoPoint? sourceLocation;
  final GeoPoint? destinationLocation;
  final double? distance;
  final DocumentReference? driverId;
  final DocumentReference? riderId;
  final String? travellingTime;
  final String? tripDate;
  final String? tripId;
  final bool? isCompleted;
  final int? tripAmount;
  final double? rating;
  final bool? isArrived;
  final bool? readyForTrip;
  final bool? isPaymentDone;

  TripHistoryEntity(
      {this.source,
      this.destination,
      this.sourceLocation,
      this.destinationLocation,
      this.distance,
      this.driverId,
      this.riderId,
      this.travellingTime,
      this.tripDate,
      this.tripId,
      this.isCompleted,
      this.tripAmount,
      this.rating,
      this.isArrived,
      this.readyForTrip,
      this.isPaymentDone});

  @override
  List<Object?> get props => [
        source,
        destination,
        sourceLocation,
        destinationLocation,
        distance,
        driverId,
        riderId,
        travellingTime,
        tripDate,
        tripId,
        isCompleted,
        tripAmount,
        rating,
        isArrived,
        readyForTrip,
        isPaymentDone
      ];
}
