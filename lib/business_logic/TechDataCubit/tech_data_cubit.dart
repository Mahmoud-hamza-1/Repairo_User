import 'package:bloc/bloc.dart';
import 'package:repairo_app_new/business_logic/TechDataCubit/tech_data_states.dart';
import 'package:repairo_app_new/data/models/tech_data_model.dart';
import 'package:repairo_app_new/data/repository/technician_data_repository.dart';

class TechDataCubit extends Cubit<TechDataStates> {
  TechDataCubit(this.technicianDataRepository) : super(TechDataInitial());

  final TechnicianDataRepository technicianDataRepository;
  late RTecPData techdata;

  Future<RTecPData?> getTechData(String id) async {
    emit(TechDataLoading());
    try {
      final techinfo = await technicianDataRepository.getTechPData(id);
      print("insideee techp cubitttt");
      print(techinfo);
      emit(TechDataLoaded(techdata: techinfo));
      return techinfo;
    } catch (e) {
      print("error in cubit: $e");
      emit(TechDataFailed(e.toString()));
      return null;
    }
  }
}
