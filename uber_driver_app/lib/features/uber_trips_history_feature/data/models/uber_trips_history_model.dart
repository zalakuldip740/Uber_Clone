import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/entities/trips_history_entity.dart';

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
  final bool? ready_for_trip;

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
        tripId: documentSnapshot.get('trip_id'),
        tripAmount: documentSnapshot.get('trip_amount'),
        rating: documentSnapshot.get('rating'),
        driverId: documentSnapshot.get('driver_id'),
        riderId: documentSnapshot.get('rider_id'),
        isArrived: documentSnapshot.get('is_arrived'),
        ready_for_trip: documentSnapshot.get('ready_for_trip'));
  }

  const TripHistoryModel(
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
      required this.ready_for_trip,
      this.driverId,
      required this.riderId,
      required this.isArrived,
     })
      : super();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source,
      'destination': destination,
      'source_location': sourceLocation,
      'destination_location': destinationLocation,
      'distance': distance,
      'travelling_time': travellingTime,
      'is_completed': isCompleted,
      'trip_date': tripDate,
      'trip_id': tripId,
      'trip_amount': tripAmount,
      'rating': rating,
      'rider_id': riderId,
      'is_arrived': isArrived,
      'ready_for_trip': ready_for_trip,
    };
  }

  factory TripHistoryModel.fromJson(Map<dynamic, dynamic> value, String id) {
    return TripHistoryModel(
        source: value['source'],
        destination: value['destination'],
        sourceLocation: value['source_location'],
        destinationLocation: value['destination_location'],
        distance: value['distance'],
        travellingTime: value['travelling_time'],
        isCompleted: value['is_completed'],
        isArrived: value['is_arrived'],
        tripDate: DateTime.parse(value['trip_date']).toString(),
        tripId: id,
        tripAmount: value['trip_amount'],
        rating: double.parse(value['rating'].toString()),
        riderId: value['rider_id'],
        ready_for_trip: value['ready_for_trip'],
       );
  }
}
