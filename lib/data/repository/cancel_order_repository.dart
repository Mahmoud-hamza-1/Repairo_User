import 'package:repairo_app_new/data/web_services/cancel_order_webservice.dart';

class CancelOrderRepository {
  final CancelOrderWebservice cancelOrderWebservice;

  CancelOrderRepository(this.cancelOrderWebservice);

  Future<void> cancelorder({
    required String id,
    required String reason,
  }) async {
    final data = await cancelOrderWebservice.cancelorder(
      id: id,
      reason: reason,
    );
    print(data);
  }
}
