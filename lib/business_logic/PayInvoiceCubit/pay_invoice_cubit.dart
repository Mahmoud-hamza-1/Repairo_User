import 'package:repairo_app_new/business_logic/PayInvoiceCubit/pay_invoice_states.dart';
import 'package:repairo_app_new/data/repository/pay_invoice_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PayInvoiceCubit extends Cubit<PayInvoiceStates> {
  final PayInvoiceRepository payInvoiceRepository;

  PayInvoiceCubit(this.payInvoiceRepository) : super(PayInvoiceInitial());

  void payinvoice({
    required String id,
    required String paymenttype,
  }) async {
    emit(PayInvoiceLoading());
    try {
      final result = await payInvoiceRepository.payinvoice(
        id: id,
        paymenttype: paymenttype,
      );

      if (result['success'] == true) {
        emit(PayInvoiceSuccess(result['message'] ?? "تم الدفع بنجاح"));
      } else {
        emit(PayInvoiceError(result['message'] ?? "فشل الدفع"));
      }
    } catch (e) {
      emit(PayInvoiceError(e.toString()));
    }
  }
}
