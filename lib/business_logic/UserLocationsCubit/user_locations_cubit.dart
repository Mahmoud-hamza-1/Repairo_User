import 'package:repairo_app_new/business_logic/UserLocationsCubit/user_locations_states.dart';
import 'package:repairo_app_new/data/models/user_location_model.dart';
import 'package:repairo_app_new/data/repository/all_locations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLocationsCubit extends Cubit<UserLocationsStates> {
  UserLocationsCubit(this.allLocationsRepository)
      : super(UserLocationsInitial());

  final AllLocationsRepository allLocationsRepository;
  late List<RUserLocationData> locations = [];

  Future<void> getLocations(String id) async {
    emit(UserLocationsLoading());

    try {
      final thelocations = await allLocationsRepository.getLocations(id);
      locations = thelocations;
      emit(UserLocationsLoaded(locations: thelocations));
    } catch (e) {
      emit(UserLocationsFailed(e.toString()));
    }
  }
}
