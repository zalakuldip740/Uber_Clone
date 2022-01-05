import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
      return querySnap.docs.reversed
          .map((docSnap) => TripHistoryModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> uberGiveTripRating(
      double rating, String tripId, String driverId) async {
    var driverOverAllRating = "".obs;
    final tripsCollectionRef = firestore.collection("trips");
    await tripsCollectionRef
        .doc(tripId)
        .update({'rating': rating}).whenComplete(() async {
      final driverDocRef = firestore.collection('drivers').doc(driverId);
      await driverDocRef.get().then((value) {
        driverOverAllRating.value = value.get('overall_rating');
      }).whenComplete(() {
        if (driverOverAllRating.value == "0") {
          driverDocRef.update({'overall_rating': rating.toString()});
        } else {
          driverDocRef.update({
            'overall_rating':
                ((double.parse(driverOverAllRating.value) + rating) / 2)
                    .toString()
          });
        }
      });
    });
  }
}
