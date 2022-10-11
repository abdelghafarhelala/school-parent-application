class SchoolModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  SchoolModel({this.result, this.errorMessage, this.errorMessageEn, this.data});

  SchoolModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? ord;
  String? name;
  String? logo;
  String? images;
  String? slug;
  String? adress;
  String? notes;
  String? latitude;
  String? langitude;
  String? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<Teachers>? teachers;
  List<Stages>? stages;

  Data(
      {this.id,
      this.ord,
      this.name,
      this.logo,
      this.images,
      this.slug,
      this.adress,
      this.notes,
      this.latitude,
      this.langitude,
      this.isActive,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.teachers,
      this.stages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    name = json['name'];
    logo = json['logo'];
    images = json['images'];
    slug = json['slug'];
    adress = json['adress'];
    notes = json['notes'];
    latitude = json['latitude'];
    langitude = json['langitude'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(new Teachers.fromJson(v));
      });
    }
    if (json['stages'] != null) {
      stages = <Stages>[];
      json['stages'].forEach((v) {
        stages!.add(new Stages.fromJson(v));
      });
    }
  }
}

class Teachers {
  int? id;
  int? schoolId;
  String? name;
  String? email;
  String? gender;
  int? countryId;
  int? cityId;
  String? nationalId;
  String? password;
  String? userName;
  String? adress;
  int? mobile;
  String? subject;
  String? isActive;
  String? createdAt;
  String? image;
  String? updatedAt;
  String? deletedAt;
  int? ord;

  Teachers(
      {this.id,
      this.schoolId,
      this.name,
      this.email,
      this.gender,
      this.countryId,
      this.cityId,
      this.nationalId,
      this.password,
      this.userName,
      this.adress,
      this.mobile,
      this.subject,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.image,
      this.ord});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    nationalId = json['national_id'];
    password = json['password'];
    userName = json['user_name'];
    adress = json['adress'];
    mobile = json['mobile'];
    subject = json['subject'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    deletedAt = json['deleted_at'];
    ord = json['ord'];
  }
}

class Stages {
  int? id;
  int? ord;
  int? schoolId;
  String? name;
  String? img;
  String? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Stages(
      {this.id,
      this.ord,
      this.schoolId,
      this.name,
      this.img,
      this.isActive,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Stages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ord = json['ord'];
    schoolId = json['school_id'];
    name = json['name'];
    img = json['img'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
