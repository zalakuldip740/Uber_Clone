import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';

class TripHistoryModel extends TripHistoryEntity {
  final String? source;
  final String? destination;
  final GeoPoint? sourceLocation;
  final GeoPoint? destinationLocation;
  final double? distance;
  final String? travellingTime;
  final String? tripDate;
  final String? tripId;
  final bool? isCompleted;
  final int? tripAmount;
  final double? rating;
  final DocumentReference? driverId;
  final DocumentReference? riderId;
  final bool? isArrived;
  final String? vehicleType;
  final String? driverName;

  factory TripHistoryModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return TripHistoryModel(
        source: documentSnapshot.get('source'),
        destination: documentSnapshot.get('destination'),
        sourceLocation: documentSnapshot.get('source_location'),
        destinationLocation: documentSnapshot.get('destination_location'),
        distance: documentSnapshot.get('distance'),
        travellingTime: documentSnapshot.get('travelling_time'),
        isCompleted: documentSnapshot.get('is_completed'),
        tripDate: documentSnapshot.get('trip_date'),
        //DateTime.parse(documentSnapshot.get('trip_date')),
        tripId: documentSnapshot.get('trip_id'),
        tripAmount: documentSnapshot.get('trip_amount'),
        rating: documentSnapshot.get('rating'),
        driverId: documentSnapshot.get('driver_id'),
        riderId: documentSnapshot.get('rider_id'),
        isArrived: documentSnapshot.get('is_arrived'),
        driverName: documentSnapshot.get('driver_name'),
        vehicleType: documentSnapshot.get('vehicleType'));
  }

  TripHistoryModel(
      {required this.source,
      required this.destination,
      required this.sourceLocation,
      required this.destinationLocation,
      required this.distance,
      required this.travellingTime,
      required this.isCompleted,
      required this.tripDate,
      required this.tripId,
      required this.tripAmount,
      required this.rating,
      required this.driverId,
      required this.riderId,
      required this.isArrived,
      required this.driverName,
      required this.vehicleType})
      : super(
            source: source,
            destination: destination,
            sourceLocation: sourceLocation,
            destinationLocation: destinationLocation,
            distance: distance,
            travellingTime: travellingTime,
            isCompleted: isCompleted,
            tripDate: tripDate,
            tripId: tripId,
            rating: rating,
            tripAmount: tripAmount,
            driverId: driverId,
            isArrived: isArrived,
            driverName: driverName,
            vehicleType: vehicleType,
            riderId: riderId);
}
