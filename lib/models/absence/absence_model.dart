class AbsenceModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  AbsenceModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  AbsenceModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  List<StudentAbcence>? studentAbcence;

  Data({this.id, this.name, this.image, this.studentAbcence});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['student_abcence'] != null) {
      studentAbcence = <StudentAbcence>[];
      json['student_abcence'].forEach((v) {
        studentAbcence!.add(StudentAbcence.fromJson(v));
      });
    }
  }
}

class StudentAbcence {
  int? id;
  int? studentId;
  String? date;
  String? reason;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  StudentAbcence(
      {this.id,
      this.studentId,
      this.date,
      this.reason,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  StudentAbcence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    date = json['date'];
    reason = json['reason'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
