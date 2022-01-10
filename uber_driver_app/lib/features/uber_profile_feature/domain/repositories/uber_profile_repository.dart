

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/driver_entity.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/vehicle_entity.dart';

abstract class UberProfileRepository {
  Stream<DriverEntity> getDriverProfile(String driverId);
  Future<void> updateDriverProfile(DriverEntity driverEntity, String driverId);
  Future<void> uberAuthUploadVehicleData(DocumentReference path,VehicleEntity vehicleEntity);
}
