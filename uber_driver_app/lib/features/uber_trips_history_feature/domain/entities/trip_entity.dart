
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/rider_model.dart';
import 'package:uber_driver_app/features/uber_trips_history_feature/data/models/uber_trips_history_model.dart';

class TripEntity {
final TripHistoryModel tripHistoryModel;
final RiderModel riderModel;

  TripEntity(this.tripHistoryModel, this.riderModel);
}