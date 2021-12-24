import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/data_sources/uber_profile_data_source.dart';
import 'package:uber_rider_app/features/uber_profile_feature/data/models/uber_profile_rider_model.dart';

class UberProfileDataSourceImpl extends UberProfileDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  UberProfileDataSourceImpl({required this.firestore, required this.auth});
  @override
  Future<RiderModel> getRiderProfile(String riderId) async {
    final riderCollectionRef = firestore.collection('riders');

    return riderCollectionRef
        .doc(riderId)
        .get()
        .then((value) => RiderModel.fromMap(value.data()));
  }

  @override
  Future<void> updateRiderProfile(RiderModel riderModel, String riderId) async {
    final riderCollection = firestore.collection("riders");
    return riderCollection.doc(riderId).update(riderModel.toDocument());
  }
}
