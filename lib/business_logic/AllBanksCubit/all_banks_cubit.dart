
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repairo_app_new/business_logic/AllBanksCubit/all_banks_states.dart';
import 'package:repairo_app_new/data/models/bank_model.dart';
import 'package:repairo_app_new/data/repository/bank_repository.dart';

class AllbanksCubit extends Cubit<AllbanksStates> {
  AllbanksCubit(this.banksRepository) : super(AllbanksInitial());

  final BanksRepository banksRepository;
  late List<RBankData> banks = [];

  Future<List<RBankData>> getAllbanks() async {
    banksRepository.getAllBanks().then((thebanks) {
      emit(AllbanksLoaded(banks: thebanks));
      banks = thebanks;
    });
    return banks;
  }
}
