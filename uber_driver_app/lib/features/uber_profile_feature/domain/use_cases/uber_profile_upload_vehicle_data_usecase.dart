import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/entities/vehicle_entity.dart';
import 'package:uber_driver_app/features/uber_profile_feature/domain/repositories/uber_profile_repository.dart';

class UberUploadDriverVehicleDataUseCase {
  final UberProfileRepository uberProfileRepository;
  UberUploadDriverVehicleDataUseCase({required this.uberProfileRepository});

  Future<void> call(DocumentReference path,VehicleEntity vehicleEntity) async {
    return await uberProfileRepository.uberAuthUploadVehicleData(path, vehicleEntity);
  }
}
