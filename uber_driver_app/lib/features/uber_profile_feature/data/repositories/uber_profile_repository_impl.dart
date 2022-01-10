import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/models/uber_profile_driver_model.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/models/vehicle_model.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/driver_entity.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/vehicle_entity.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberProfileRepositoryImpl extends UberProfileRepository {
  final UberProfileDataSource uberProfileDataSource;

  UberProfileRepositoryImpl({required this.uberProfileDataSource});

  @override
  Stream<DriverProfileModel> getDriverProfile(String driverId) {
    return uberProfileDataSource.getDriverProfile(driverId);
  }

  @override
  Future<void> updateDriverProfile(
      DriverEntity driverEntity, String driverId) async {
    final driverModel = DriverProfileModel(
        name: driverEntity.name,
        email: driverEntity.email,
        mobile: driverEntity.mobile,
        overall_rating: driverEntity.overall_rating,
        profile_img: driverEntity.profile_img,
        wallet: driverEntity.wallet,
        city: driverEntity.city,
        is_online: driverEntity.is_online,
        driver_id: driverEntity.driver_id,
        current_location: driverEntity.current_location,
        vehicle: driverEntity.vehicle);
    return await uberProfileDataSource.updateDriverProfile(
        driverModel, driverId);
  }

  @override
  Future<void> uberAuthUploadVehicleData(
      DocumentReference<Object?> path, VehicleEntity vehicleEntity) async {
    final vehicleModel = VehicleModel(
        comapany: vehicleEntity.comapany,
        number_plate: vehicleEntity.number_plate,
        color: vehicleEntity.color,
        model: vehicleEntity.model);

    await uberProfileDataSource.uberAuthUploadVehicleData(path, vehicleModel);
  }
}
