import 'package:repairo_app_new/data/models/request_details_model.dart';

abstract class RequestDetailsStates {}

class RequestDetailsInitial extends RequestDetailsStates {}

class RequestDetailsLoading extends RequestDetailsStates {}

class RequestDetailsSuccess extends RequestDetailsStates {
  final RRequestDetailsData requestdata;
  RequestDetailsSuccess(this.requestdata);
}

class RequestDetailsError extends RequestDetailsStates {
  final String message;
  RequestDetailsError(this.message);
}

