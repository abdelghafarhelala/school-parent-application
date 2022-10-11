class ProfileModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  ProfileModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  int? nationalId;
  String? gender;
  String? email;
  String? mobile;
  String? password;
  int? countryId;
  int? cityId;
  int? regionId;
  String? address;
  int? relationId;
  String? img;
  String? nationalIdImage;
  String? isActive;
  String? deletedAt;
  int? ord;
  List<Students>? students;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.nationalId,
      this.gender,
      this.email,
      this.mobile,
      this.password,
      this.countryId,
      this.cityId,
      this.regionId,
      this.address,
      this.relationId,
      this.img,
      this.nationalIdImage,
      this.isActive,
      this.deletedAt,
      this.ord,
      this.students});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    nationalId = json['national_id'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    address = json['address'];
    relationId = json['relation_id'];
    img = json['img'];
    nationalIdImage = json['national_id_image'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    ord = json['ord'];
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) {
        students!.add(Students.fromJson(v));
      });
    }
  }
}

class Students {
  int? id;
  int? schoolId;
  String? name;
  String? image;
  String? dateBirth;
  String? gender;
  int? countryId;
  int? cityId;
  int? regionId;
  String? address;
  int? mobile;
  String? nationalId;
  int? parentId;
  String? userName;
  String? password;
  String? ord;
  double? latitude;
  double? longitude;
  String? oneSignalId;
  String? isActive;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  ClassroomsStudents? classroomsStudents;
  ClassRooms? classRooms;

  Students(
      {this.id,
      this.schoolId,
      this.name,
      this.image,
      this.dateBirth,
      this.gender,
      this.countryId,
      this.cityId,
      this.regionId,
      this.address,
      this.mobile,
      this.nationalId,
      this.parentId,
      this.userName,
      this.password,
      this.ord,
      this.latitude,
      this.longitude,
      this.oneSignalId,
      this.isActive,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.classroomsStudents,
      this.classRooms});

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    name = json['name'];
    image = json['image'];
    dateBirth = json['date_birth'];
    gender = json['gender'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    regionId = json['region_id'];
    address = json['adress'];
    mobile = json['mobile'];
    nationalId = json['national_id'];
    parentId = json['parent_id'];
    userName = json['user_name'];
    password = json['password'];
    ord = json['ord'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    oneSignalId = json['onesignal_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    classroomsStudents = json['classrooms_students'] != null
        ? ClassroomsStudents.fromJson(json['classrooms_students'])
        : null;
    classRooms = json['class_rooms'] != null
        ? ClassRooms.fromJson(json['class_rooms'])
        : null;
  }
}

class ClassroomsStudents {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? studentId;
  int? classRoomId;
  String? notes;
  String? year;
  String? isActive;
  String? deletedAt;
  int? seatNumber;
  int? ord;

  ClassroomsStudents(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.studentId,
      this.classRoomId,
      this.notes,
      this.year,
      this.isActive,
      this.deletedAt,
      this.seatNumber,
      this.ord});

  ClassroomsStudents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    studentId = json['student_id'];
    classRoomId = json['class_room_id'];
    notes = json['notes'];
    year = json['year'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    seatNumber = json['seat_number'];
    ord = json['ord'];
  }
}

class ClassRooms {
  int? id;
  String? name;
  String? notes;
  int? schoolId;
  int? stageId;
  String? isActive;
  Null? deletedAt;
  int? maxDegree;
  int? minDegree;
  int? ord;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;

  ClassRooms(
      {this.id,
      this.name,
      this.notes,
      this.schoolId,
      this.stageId,
      this.isActive,
      this.deletedAt,
      this.maxDegree,
      this.minDegree,
      this.ord,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey});

  ClassRooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    notes = json['notes'];
    schoolId = json['school_id'];
    stageId = json['stage_id'];
    isActive = json['is_active'];
    deletedAt = json['deleted_at'];
    maxDegree = json['max_degree'];
    minDegree = json['min_degree'];
    ord = json['ord'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
  }
}
