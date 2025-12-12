import 'package:repairo_app_new/business_logic/ProvidedServicesCubit/provided_services_states.dart';
import 'package:repairo_app_new/data/repository/provided_services_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvidedServicesCubit extends Cubit<ProvidedServicesStates> {
  final ProvidedServicesRepository providedServicesRepository;

  ProvidedServicesCubit(this.providedServicesRepository)
      : super(ProvidedServicesInitial());

  // Future<RProvidedServicesData> getThisTechServices(
  //     String id, List<String> selectedervices) async {
  //   emit(ProvidedServicesLoading());
  //   try {
  //     final techServices = await providedServicesRepository.getThisTechServices(
  //         id, selectedervices);
  //     emit(ProvidedServicesSuccess(techServices));
  //     Get.back();
  //     Get.toNamed('verification');
  //   } catch (e) {
  //     emit(LoginError(e.toString()));
  //   }
  // }

  Future<void> fetchProvidedServices(
      String techId, List<String>? selectedServiceIds) async {
    emit(ProvidedServicesLoading());

    try {
      final services = await providedServicesRepository.getThisTechServices(
          techId, selectedServiceIds ?? []);

      emit(ProvidedServicesSuccess(services));
    } catch (e) {
      emit(ProvidedServicesError(e.toString()));
    }
  }
}
