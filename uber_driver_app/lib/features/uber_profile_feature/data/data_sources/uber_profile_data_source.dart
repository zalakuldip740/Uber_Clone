
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/models/uber_profile_driver_model.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/models/vehicle_model.dart';

abstract class UberProfileDataSource {
  Stream<DriverProfileModel> getDriverProfile(String driverId);
  Future<void> updateDriverProfile(DriverProfileModel driverModel, String driverId);
  Future<void> uberAuthUploadVehicleData(DocumentReference path,VehicleModel model);

}
