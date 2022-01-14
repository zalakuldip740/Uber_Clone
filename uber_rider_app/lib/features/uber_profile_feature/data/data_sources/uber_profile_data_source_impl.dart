import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/models/uber_profile_rider_model.dart';

class UberProfileDataSourceImpl extends UberProfileDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UberProfileDataSourceImpl({required this.firestore, required this.auth});

  @override
  Stream<RiderModel> getRiderProfile(String riderId) {
    final riderCollectionRef = firestore.collection('riders');
    return riderCollectionRef
        .doc(riderId)
        .snapshots()
        .map((data) => RiderModel.fromSnapShot(data));
  }

  @override
  Future<void> updateRiderProfile(RiderModel riderModel, String riderId) async {
    final riderCollection = firestore.collection("riders");
    try {
      riderCollection
          .doc(riderId)
          .set(riderModel.toDocument())
          .whenComplete(() {
        Get.snackbar("Done", "Profile Updated!",
            snackPosition: SnackPosition.BOTTOM);
      });
    } on FirebaseException catch (e) {
      Get.snackbar("error", e.code.toString());
    }
  }

  @override
  Future<void> walletAddMoney(String riderId, int addAmt) async {
    try {
      await firestore
          .collection("riders")
          .doc(riderId)
          .get()
          .then((value) async {
        await firestore
            .collection("riders")
            .doc(riderId)
            .update({'wallet': value.get('wallet') + addAmt});
      });
    } on FirebaseException catch (e) {
      Get.snackbar("Error", e.code.toString());
    }
  }
}
