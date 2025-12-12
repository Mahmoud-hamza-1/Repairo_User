class topUpRequest {
  bool? success;
  String? message;
  List<RTopUpRequestData>? data;

  topUpRequest({this.success, this.message, this.data});

  topUpRequest.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RTopUpRequestData>[];
      json['data'].forEach((v) {
        data!.add(RTopUpRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RTopUpRequestData {
  String? id;
  String? userId;
  String? bankId;
  String? amount;
  String? status;
  Bank? bank;
  String? image;

  RTopUpRequestData(
      {this.id,
      this.userId,
      this.bankId,
      this.amount,
      this.status,
      this.bank,
      this.image});

  RTopUpRequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bankId = json['bank_id'];
    amount = json['amount'];
    status = json['status'];
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['bank_id'] = bankId;
    data['amount'] = amount;
    data['status'] = status;
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class Bank {
  String? id;
  String? name;
  String? accountName;
  String? accountNumber;
  String? iban;
  String? image;

  Bank(
      {this.id,
      this.name,
      this.accountName,
      this.accountNumber,
      this.iban,
      this.image});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    iban = json['iban'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['iban'] = iban;
    data['image'] = image;
    return data;
  }
}
