
import 'package:uber_driver_app/core/data_sources/remote_data_source/firebase/firebase_data_source.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/driver_model.dart';

import '../../domain/repositories/driver_location_repository.dart';

class DriverLocationRepositoryImpl implements DriverLocationRepository{
  final FirebaseDataSource firebaseNearByMeDataSource;

  DriverLocationRepositoryImpl({required this.firebaseNearByMeDataSource});
  @override
  Stream<DriverModel> tripDriverStream(String? driverId) {
    return firebaseNearByMeDataSource.oneStream(
        path: 'drivers',
        builder: (data) =>  DriverModel.fromJson(data),
        queryBuilder: (query) => query.
        where('driver_id', isEqualTo: driverId)
    );
  }

  @override
  Future<void> updateDriver(DriverModel driverModel) async {
    firebaseNearByMeDataSource.setData(
      path: 'drivers/${driverModel.driver_id}',
      data: driverModel.toMap(),
    );
  }

}