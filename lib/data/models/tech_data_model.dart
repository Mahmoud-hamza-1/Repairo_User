class TechData {
  bool? success;
  String? message;
  RTecPData? data;

  TechData({this.success, this.message, this.data});

  TechData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? RTecPData.fromJson(json['data']) : null;
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

class RTecPData {
  String? id;
  String? name;
  String? place;
  String? rating;
  String? jobCategoryId;
  Category? category;
  List<PreviousWorks>? previousWorks;
  String? image;

  RTecPData(
      {this.id,
      this.name,
      this.place,
      this.rating,
      this.jobCategoryId,
      this.category,
      this.previousWorks,
      this.image});

  RTecPData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    place = json['place'];
    rating = json['rating'];
    jobCategoryId = json['job_category_id'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['previous_works'] != null) {
      previousWorks = <PreviousWorks>[];
      json['previous_works'].forEach((v) {
        previousWorks!.add(PreviousWorks.fromJson(v));
      });
    }
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['place'] = place;
    data['rating'] = rating;
    data['job_category_id'] = jobCategoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (previousWorks != null) {
      data['previous_works'] = previousWorks!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    return data;
  }
}

class Category {
  String? id;
  String? displayName;

  Category({this.id, this.displayName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['display_name'] = displayName;
    return data;
  }
}

class PreviousWorks {
  String? id;
  String? title;
  String? description;
  String? technicianAccountId;
  List<String>? image;

  PreviousWorks(
      {this.id,
      this.title,
      this.description,
      this.technicianAccountId,
      this.image});

  PreviousWorks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    technicianAccountId = json['technician_account_id'];
    if (json['image'] != null) {
      image = List<String>.from(json['image']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['technician_account_id'] = technicianAccountId;
    if (image != null) {
      data['image'] = image;
    }

    return data;
  }
}
