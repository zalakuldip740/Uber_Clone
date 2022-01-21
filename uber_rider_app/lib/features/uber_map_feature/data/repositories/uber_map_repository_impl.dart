import 'package:uber_rider_app/features/uber_map_feature/data/data_sources/uber_map_data_source.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/generate_trip_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/rental_charges_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/uber_map_drivers_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/data/models/vehicle_details_model.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/entities/uber_map_direction_entity.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/entities/uber_map_prediction_entity.dart';
import 'package:uber_rider_app/features/uber_map_feature/domain/repositories/uber_map_repository.dart';

class UberMapRepositoryImpl extends UberMapRepository {
  final UberMapDataSource uberMapDataSource;

  UberMapRepositoryImpl({required this.uberMapDataSource});

  @override
  Future<List<UberMapPredictionEntity>> getUberMapPrediction(
      String placeName) async {
    final predictionsList =
        await uberMapDataSource.getUberMapPrediction(placeName);
    List<UberMapPredictionEntity> uberMapPredictionEntityList = [];
    for (int i = 0; i < predictionsList.predictions!.length; i++) {
      final data = UberMapPredictionEntity(
          secondaryText: predictionsList
              .predictions![i].structuredFormatting!.secondaryText,
          mainText:
              predictionsList.predictions![i].structuredFormatting!.mainText,
          placeId: predictionsList.predictions![i].placeId);
      uberMapPredictionEntityList.add(data);
    }
    return uberMapPredictionEntityList;
  }

  @override
  Future<List<UberMapDirectionEntity>> getUberMapDirection(double sourceLat,
      double sourceLng, double destinationLat, double destinationLng) async {
    final directionList = await uberMapDataSource.getUberMapDirection(
        sourceLat, sourceLng, destinationLat, destinationLng);
    List<UberMapDirectionEntity> uberMapDirectionEntityList = [];
    for (int i = 0; i < directionList.routes!.length; i++) {
      final directionData = UberMapDirectionEntity(
          distanceValue: directionList.routes![0].legs![0].distance!.value,
          durationValue: directionList.routes![0].legs![0].duration!.value,
          distanceText: directionList.routes![0].legs![0].distance!.text,
          durationText: directionList.routes![0].legs![0].duration!.text,
          enCodedPoints: directionList.routes![0].overviewPolyline!.points);
      uberMapDirectionEntityList.add(directionData);
    }

    return uberMapDirectionEntityList;
  }

  @override
  Stream<List<DriverModel>> getAvailableDrivers() {
    return uberMapDataSource.getAvailableDrivers();
  }

  @override
  Future<RentalChargeModel> getRentalChargeForVehicle(double kms) async {
    return await uberMapDataSource.getRentalChargeForVehicle(kms);
  }

  @override
  Stream generateTrip(GenerateTripModel generateTripModel) {
    return uberMapDataSource.generateTrip(generateTripModel);
  }

  @override
  Future<VehicleModel> getVehicleDetails(
      String vehicleType, String driverId) async {
    return await uberMapDataSource.getVehicleDetails(vehicleType, driverId);
  }

  @override
  Future<void> cancelTrip(String tripId, bool isNewTripGeneration) async {
    return await uberMapDataSource.cancelTrip(tripId, isNewTripGeneration);
  }

  @override
  Future<String> tripPayment(String riderId, String driverId, int tripAmount,
      String tripId, String payMode) async {
    return await uberMapDataSource.tripPayment(
        riderId, driverId, tripAmount, tripId, payMode);
  }
}
