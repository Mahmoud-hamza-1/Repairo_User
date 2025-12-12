class ServicesProvidersSearch {
  bool? success;
  String? message;
  List<RSearchesServiceProvidersData>? data;

  ServicesProvidersSearch({this.success, this.message, this.data});

  ServicesProvidersSearch.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RSearchesServiceProvidersData>[];
      json['data'].forEach((v) {
        data!.add(RSearchesServiceProvidersData.fromJson(v));
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

class RSearchesServiceProvidersData {
  String? id;
  String? name;
  String? rating;
  String? image;

  RSearchesServiceProvidersData({this.id, this.name, this.rating, this.image});

  RSearchesServiceProvidersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rating'] = rating;
    data['image'] = image;
    return data;
  }
}
