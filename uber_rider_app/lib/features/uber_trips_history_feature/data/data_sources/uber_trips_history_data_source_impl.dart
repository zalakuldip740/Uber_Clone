import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/data/data_sources/uber_trips_history_data_source.dart';
import 'package:uber_rider_app/features/uber_trips_history_feature/data/models/uber_trips_history_model.dart';

class UberTripsHistoryDataSourceImpl extends UberTripsHistoryDataSource {
  final FirebaseFirestore firestore;
  UberTripsHistoryDataSourceImpl({required this.firestore});
  @override
  Stream<List<TripHistoryModel>> uberGetTripHistory(String riderId) {
    final tripsCollectionRef = firestore.collection("trips").where('rider_id',
        isEqualTo:
            FirebaseFirestore.instance.collection('riders').doc(riderId));

    return tripsCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => TripHistoryModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> uberGiveTripRating(double rating, String tripId) {
    final tripsCollectionRef = firestore.collection("trips");
    return tripsCollectionRef.doc(tripId).update({'rating': rating});
  }
}
