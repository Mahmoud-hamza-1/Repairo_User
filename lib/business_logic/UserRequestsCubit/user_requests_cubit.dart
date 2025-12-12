import 'package:bloc/bloc.dart';
import 'package:repairo_app_new/business_logic/UserRequestsCubit/user_requests_states.dart';
import 'package:repairo_app_new/data/models/user_requests_model.dart';
import 'package:repairo_app_new/data/repository/user_requests_repository.dart';

class UserRequestsCubit extends Cubit<UserRequestsStates> {
  UserRequestsCubit(this.userRequestsRepository) : super(UserRequestsInitial());

  final UserRequestsRepository userRequestsRepository;
  late List<RUserRequestData> requests = [];

  Future<List<RUserRequestData>> getUserRequests({
    String? status,
  }) async {
    userRequestsRepository.getAllRequests(status: status).then((therequests) {
      emit(UserRequestsLoaded(requests: therequests));
      requests = therequests;
    });
    return requests;
  }
}
