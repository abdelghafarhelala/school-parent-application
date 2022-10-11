class HomeModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  HomeModel({this.result, this.errorMessage, this.errorMessageEn, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['error_message'] = this.errorMessage;
    data['error_message_en'] = this.errorMessageEn;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Student>? student;

  Data({this.student});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['student'] != null) {
      student = <Student>[];
      json['student'].forEach((v) {
        student!.add(new Student.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.student != null) {
      data['student'] = this.student!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Student {
  int? id;
  int? schoolId;
  String? name;
  String? image;
  String? dateBirth;
  String? gender;
  String? address;
  int? mobile;
  String? nationalId;
  int? parentId;
  String? userName;
  double? latitude;
  double? longitude;
  String? onesignalId;

  Student(
      {this.id,
      this.schoolId,
      this.name,
      this.image,
      this.dateBirth,
      this.gender,
      this.address,
      this.mobile,
      this.nationalId,
      this.parentId,
      this.userName,
      this.latitude,
      this.longitude,
      this.onesignalId});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    name = json['name'];
    image = json['image'];
    dateBirth = json['date_birth'];
    gender = json['gender'];
    address = json['address'];
    mobile = json['mobile'];
    nationalId = json['national_id'];
    parentId = json['parent_id'];
    userName = json['user_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    onesignalId = json['onesignal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_id'] = this.schoolId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['date_birth'] = this.dateBirth;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['national_id'] = this.nationalId;
    data['parent_id'] = this.parentId;
    data['user_name'] = this.userName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['onesignal_id'] = this.onesignalId;
    return data;
  }
}
