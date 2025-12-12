class Copouns {
  bool? success;
  String? message;
  List<RCoponusData>? data;

  Copouns({this.success, this.message, this.data});

  Copouns.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RCoponusData>[];
      json['data'].forEach((v) {
        data!.add(RCoponusData.fromJson(v));
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

class RCoponusData {
  String? id;
  String? userId;
  String? coupon;
  String? type;
  String? value;
  int? active;

  RCoponusData(
      {this.id, this.userId, this.coupon, this.type, this.value, this.active});

  RCoponusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    coupon = json['coupon'];
    type = json['type'];
    value = json['value'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['coupon'] = coupon;
    data['type'] = type;
    data['value'] = value;
    data['active'] = active;
    return data;
  }
}
