import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/uber_map_drivers_model.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/domain/entities/uber_trips_history_entity.dart';

class TripHistoryModel extends TripHistoryEntity {
  final String? source;
  final String? destination;
  final GeoPoint? sourceLocation;
  final GeoPoint? destinationLocation;
  final double? distance;
  final String? travellingTime;
  final DateTime? tripDate;
  final String? tripId;
  final bool? isCompleted;
  final String? tripAmount;
  final double? rating;
  final DocumentReference? driverId;
  late DriverModel? driverModel;

  factory TripHistoryModel.fromJson(Map<dynamic, dynamic> value) {
    return TripHistoryModel(
      source: value['source'],
      destination: value['destination'],
      sourceLocation: value['source_location'],
      destinationLocation: value['destination_location'],
      distance: value['distance'],
      travellingTime: value['travelling_time'],
      isCompleted: value['is_completed'],
      tripDate: DateTime.parse(value['trip_date']),
      tripId: value['trip_id'],
      tripAmount: value['trip_amount'].toString(),
      rating: value['rating'],
      driverId: value['driver_id'],
      driverModel: null,
    );
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
      required this.driverModel})
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
            driverModel: driverModel);
}
