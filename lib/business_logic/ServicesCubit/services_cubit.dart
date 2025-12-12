// import 'package:bloc/bloc.dart';
// import 'package:repairo_app_new/data/models/items_model.dart';
// import 'package:repairo_app_new/data/repository/items_repository.dart';
// part 'services_states.dart';

// class ServicesCubit extends Cubit<ServicesStates> {
//   final ServicesRepository servicesRepository;
//   List<Services> items = [];

//   ServicesCubit(this.servicesRepository) : super(ServicesInitial());

//   List<Services> getAllItems() {
//     servicesRepository.getAllItems().then((theservices) {
//       emit(ServicesLoaded(services: theservices));
//       items = theservices;
//     });
//     return items;
//   }

//   void searchProducts(String query) {
//     final filtered = items
//         .where((item) =>
//             item.description.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     emit(ServicesLoaded(services: filtered));
//   }
// }
