class BankData {
  bool? success;
  String? message;
  BankDRData? data;

  BankData({this.success, this.message, this.data});

  BankData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? BankDRData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BankDRData {
  String? id;
  String? name;
  String? accountName;
  String? accountNumber;
  String? iban;
  String? image;

  BankDRData(
      {this.id,
      this.name,
      this.accountName,
      this.accountNumber,
      this.iban,
      this.image});

  BankDRData.fromJson(Map<String, dynamic> json) {
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
