import 'package:uber_rider_app/features/uber_map_feature/data/models/generate_trip_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/rental_charges_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/uber_map_direction_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/uber_map_drivers_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/uber_map_prediction_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/vehicle_details_model.dart';

abstract class UberMapDataSource {
  Future<PredictionsList> getUberMapPrediction(String placeName);

  Future<Direction> getUberMapDirection(double sourceLat, double sourceLng,
      double destinationLat, double destinationLng);

  Stream<List<DriverModel>> getAvailableDrivers();

  Future<RentalChargeModel> getRentalChargeForVehicle(double kms);

  Stream generateTrip(GenerateTripModel generateTripModel);

  Future<VehicleModel> getVehicleDetails(String vehicleType, String driverId);

  Future<void> cancelTrip(String tripId, bool isNewTripGeneration);

  Future<String> tripPayment(String riderId, String driverId, int tripAmount,
      String tripId, String payMode);
}
