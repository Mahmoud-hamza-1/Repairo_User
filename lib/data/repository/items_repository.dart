import 'package:repairo_app_new/data/models/items_model.dart';
import 'package:repairo_app_new/data/web_services/Items_webservices.dart';

class ServicesRepository {
  final ServicesWebservices servicesWebservices;

  ServicesRepository({required this.servicesWebservices});

  Future<List<Services>> getAllItems() async {
    final items = await servicesWebservices.getItems();
    return items.map((item) => Services.fromjson(item)).toList();
  }
}

