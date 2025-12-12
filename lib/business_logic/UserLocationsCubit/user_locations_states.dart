import 'package:repairo_app_new/data/models/user_location_model.dart';

abstract class UserLocationsStates {}

class UserLocationsInitial extends UserLocationsStates {}

class UserLocationsFailed extends UserLocationsStates {
  final String message;
  UserLocationsFailed(this.message);
}

class UserLocationsLoading extends UserLocationsStates {}

class UserLocationsLoaded extends UserLocationsStates {
  final List<RUserLocationData> locations;
  UserLocationsLoaded({required this.locations});
}
