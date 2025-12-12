import 'package:repairo_app_new/data/models/bank_model.dart';
import 'package:repairo_app_new/data/web_services/banks_webservices.dart';

class BanksRepository {
  final BankWebservices bankWebservices;

  BanksRepository({required this.bankWebservices});

  Future<List<RBankData>> getAllBanks() async {
    final items = await bankWebservices.getAllBanks();
    return items.map((item) => RBankData.fromJson(item)).toList();
  }
}
