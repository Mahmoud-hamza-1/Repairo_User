class Banner {
  bool? success;
  String? message;
  List<RBannerImageData>? data;

  Banner({this.success, this.message, this.data});

  Banner.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RBannerImageData>[];
      json['data'].forEach((v) {
        data!.add(RBannerImageData.fromJson(v));
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

class RBannerImageData {
  String? id;
  String? link;
  bool? status;
  String? image;

  RBannerImageData({this.id, this.link, this.status, this.image});

  RBannerImageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['link'] = link;
    data['status'] = status;
    data['image'] = image;
    return data;
  }
}
