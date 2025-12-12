import 'package:bloc/bloc.dart';
import 'package:repairo_app_new/business_logic/ServiceCubit/service_states.dart';
import 'package:repairo_app_new/data/models/service_model.dart';
import 'package:repairo_app_new/data/repository/services_repository.dart';

class ServiceCubit extends Cubit<ServiceStates> {
  ServiceCubit(this.serviceRepository) : super(ServiceInitial());

  final ServiceRepository serviceRepository;
  late List<RServiceData> services = [];

  late List selectedServices = [];

  Future<List<RServiceData>> getServices(String id) async {
    serviceRepository.getServices(id).then((theservices) {
      emit(ServiceLoaded(services: services));
      services = theservices;
    });
    return services;
  }
}
