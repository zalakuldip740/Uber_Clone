import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GenerateTripModel extends Equatable {
  final String? source;
  final String? destination;
  final GeoPoint? sourceLocation;
  final GeoPoint? destinationLocation;
  final double? distance;
  final String? travellingTime;
  final bool? isCompleted;
  final String? tripDate;
  final double? rating;
  final DocumentReference? driverId;
  final DocumentReference? riderId;
  final bool? readyForTrip;
  final int? tripAmount;
  final bool? isArrived;
  final bool? isPaymentDone;
  final String? tripId;

  const GenerateTripModel(
      this.source,
      this.destination,
      this.sourceLocation,
      this.destinationLocation,
      this.distance,
      this.travellingTime,
      this.isCompleted,
      this.tripDate,
      this.driverId,
      this.riderId,
      this.rating,
      this.readyForTrip,
      this.tripAmount,
      this.isArrived,
      this.isPaymentDone,
      this.tripId);

  @override
  // TODO: implement props
  List<Object?> get props => [
        source,
        destination,
        sourceLocation,
        destinationLocation,
        distance,
        travellingTime,
        isCompleted,
        tripDate,
        driverId,
        riderId,
        rating,
        readyForTrip,
        tripAmount,
        isArrived,
        isPaymentDone,
        tripId
      ];
}
