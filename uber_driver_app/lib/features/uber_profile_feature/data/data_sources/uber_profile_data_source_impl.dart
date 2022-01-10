import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/models/uber_profile_driver_model.dart';
import 'package:uber_driver_app/features/uber_profile_feature/data/models/vehicle_model.dart';

class UberProfileDataSourceImpl extends UberProfileDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UberProfileDataSourceImpl({required this.firestore, required this.auth});

  @override
  Stream<DriverProfileModel> getDriverProfile(String driverId) {
    final driverCollectionRef = firestore.collection('drivers');
    return driverCollectionRef
        .doc(driverId)
        .snapshots()
        .map((data) => DriverProfileModel.fromSnapShot(data));
  }

  @override
  Future<void> updateDriverProfile(DriverProfileModel driverModel, String driverId) async {
    final riderCollection = firestore.collection("drivers");
    try {
      riderCollection.doc(driverId).set(driverModel.toDocument());
    } on FirebaseException catch (e) {
      Get.snackbar("error", e.code.toString());
    }
  }

  @override
  Future<void> uberAuthUploadVehicleData(DocumentReference<Object?> path,VehicleModel model) async{
    await path.set(model.toMap());
  }



}
