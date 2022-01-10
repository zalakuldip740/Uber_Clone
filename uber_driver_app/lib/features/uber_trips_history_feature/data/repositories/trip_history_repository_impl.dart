
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uber_driver_app/core/data_sources/remote_data_source/firebase/firebase_data_source.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/driver_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/rider_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/uber_trips_history_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/entities/trip_entity.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/domain/repositories/trip_history_repository.dart';

class TripHistoryRepositoryImpl implements TripHistoryRepository{
  final FirebaseDataSource firebaseNearByMeDataSource;
  TripHistoryRepositoryImpl({required this.firebaseNearByMeDataSource});


  Stream<List<TripHistoryModel>> tripHistoryStream(bool isHistory,String driverId, String? tripId) {

    return firebaseNearByMeDataSource.collectionStream(
      path: 'trips',
      builder: (data,id) =>  TripHistoryModel.fromJson(data,id),
      queryBuilder: (query) =>
      isHistory == true ? query.
      where('driver_id', isEqualTo: FirebaseFirestore.instance.collection('drivers').doc(driverId)) :
      tripId != null ? query.where('trip_id', isEqualTo: tripId) :  query.
      where('driver_id', isEqualTo: FirebaseFirestore.instance.collection('drivers').doc(driverId))
          .where('ready_for_trip',isEqualTo: false)
      ,
      sort: (lhs, rhs) => DateTime.parse(rhs.tripDate!).compareTo(DateTime.parse(lhs.tripDate!)),
    );
  }


  Stream<List<RiderModel>> riderList() {
    return firebaseNearByMeDataSource.collectionStream(
      path: 'riders',
      builder: (data,id) =>  RiderModel.fromJson(data,id),
    );
  }

  static List<TripEntity> _combiner(
      List<TripHistoryModel> trips, List<RiderModel> riders) {
    return trips.map((trip) {
      final rider = riders.firstWhere(
            (rider) => rider.rider_id == trip.riderId!.id,
      );
      return TripEntity(trip, rider);
    }).toList();
  }

  @override
  Stream<List<TripEntity>> tripDriverStream(bool isHistory,String driverId,String? tripId) {
    return  Rx.combineLatest2(
      tripHistoryStream(isHistory,driverId,tripId),

      riderList(),
      _combiner,
    );
  }

  @override
  Future<void> updateDriverAndTrip(TripEntity tripDriver,DriverModel driverModel,bool isDriver) async {
    firebaseNearByMeDataSource.setData(
      path: 'trips/${tripDriver.tripHistoryModel.tripId}',
      data: tripDriver.tripHistoryModel.toMap(),
    );
    if(isDriver)
    {
      firebaseNearByMeDataSource.setData(
        path: 'drivers/${driverModel.driver_id}',
        data: driverModel.toMap(),
      );
    }

  }
}