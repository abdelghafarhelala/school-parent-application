class UserModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Success? success;
  Data? data;

  UserModel(
      {this.result,
      this.errorMessage,
      this.errorMessageEn,
      this.success,
      this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    success =
        json['success'] != null ? Success.fromJson(json['success']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Success {
  String? token;

  Success({this.token});

  Success.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}

class Data {
  List<Student>? student;

  Data({this.student});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['student'] != null) {
      student = <Student>[];
      json['student'].forEach((v) {
        student!.add(Student.fromJson(v));
      });
    }
  }
}

class Student {
  int? id;
  int? schoolId;
  String? name;
  String? image;
  String? dateBirth;
  String? gender;
  int? countryId;
  int? cityId;
  String? regionId;
  String? adress;
  int? mobile;
  String? nationalId;
  int? parentId;
  String? userName;
  String? password;
  String? ord;
  double? latitude;
  double? longitude;
  String? onesignalId;
  String? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Parent? parent;

  Student(
      {this.id,
      this.schoolId,
      this.name,
      this.image,
      this.dateBirth,
      this.gender,
      this.countryId,
      this.cityId,
      this.regionId,
      this.adress,
      this.mobile,
      this.nationalId,
      this.parentId,
      this.userName,
      this.password,
      this.ord,
      this.latitude,
      this.longitude,
      this.onesignalId,
      this.isActive,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.parent});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    name = json['name'];
    image = json['image'];
    dateBirth = json['date_birth'];
    gender = json['gender'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    adress = json['adress'];
    mobile = json['mobile'];
    nationalId = json['national_id'];
    parentId = json['parent_id'];
    userName = json['user_name'];
    password = json['password'];
    ord = json['ord'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    onesignalId = json['onesignal_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
  }
}

class Parent {
  int? id;
  String? name;

  Parent({this.id, this.name});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
