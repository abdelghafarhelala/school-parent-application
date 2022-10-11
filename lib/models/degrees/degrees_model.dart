class DegreesModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  DegreesModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  DegreesModel.fromJson(Map<String, dynamic> json) {
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
  List<MonthExams>? monthExams;
  List<YearWorks>? yearWorks;
  List<FinalExams>? finalExams;
  List<MidExams>? midExams;

  Data(
      {this.id,
      this.name,
      this.image,
      this.monthExams,
      this.yearWorks,
      this.finalExams,
      this.midExams});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['month_exams'] != null) {
      monthExams = <MonthExams>[];
      json['month_exams'].forEach((v) {
        monthExams!.add(MonthExams.fromJson(v));
      });
    }
    if (json['yearsworks'] != null) {
      yearWorks = <YearWorks>[];
      json['yearsworks'].forEach((v) {
        yearWorks!.add(YearWorks.fromJson(v));
      });
    }
    if (json['final_exams'] != null) {
      finalExams = <FinalExams>[];
      json['final_exams'].forEach((v) {
        finalExams!.add(FinalExams.fromJson(v));
      });
    }
    if (json['midexams'] != null) {
      midExams = <MidExams>[];
      json['midexams'].forEach((v) {
        midExams!.add(MidExams.fromJson(v));
      });
    }
  }
}

class MonthExams {
  int? id;
  int? studentId;
  int? subjectId;
  int? teacherId;
  String? date;
  String? notes;
  int? degree;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;
  Subject? subject;

  MonthExams(
      {this.id,
      this.studentId,
      this.subjectId,
      this.teacherId,
      this.date,
      this.notes,
      this.degree,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.teacher,
      this.subject});

  MonthExams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    date = json['date'];
    notes = json['notes'];
    degree = json['degree'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }
}

class MidExams {
  int? id;
  int? studentId;
  int? subjectId;
  int? teacherId;
  String? date;
  String? notes;
  int? degree;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;
  Subject? subject;

  MidExams(
      {this.id,
      this.studentId,
      this.subjectId,
      this.teacherId,
      this.date,
      this.notes,
      this.degree,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.teacher,
      this.subject});

  MidExams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    date = json['date'];
    notes = json['notes'];
    degree = json['degree'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }
}

class YearWorks {
  int? id;
  int? studentId;
  int? subjectId;
  int? teacherId;
  String? date;
  String? notes;
  int? degree;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;
  Subject? subject;

  YearWorks(
      {this.id,
      this.studentId,
      this.subjectId,
      this.teacherId,
      this.date,
      this.notes,
      this.degree,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.teacher,
      this.subject});

  YearWorks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    date = json['date'];
    notes = json['notes'];
    degree = json['degree'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }
}

class FinalExams {
  int? id;
  int? studentId;
  int? subjectId;
  int? teacherId;
  int? observerId;
  String? date;
  String? notes;
  int? degree;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Teacher? teacher;
  Subject? subject;

  FinalExams(
      {this.id,
      this.studentId,
      this.subjectId,
      this.teacherId,
      this.observerId,
      this.date,
      this.notes,
      this.degree,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.teacher,
      this.subject});

  FinalExams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    subjectId = json['subject_id'];
    teacherId = json['teacher_id'];
    observerId = json['observer_id'];
    date = json['date'];
    notes = json['notes'];
    degree = json['degree'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }
}

class Teacher {
  int? id;
  String? name;

  Teacher({this.id, this.name});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Subject {
  int? id;
  String? name;
  String? image;

  Subject({this.id, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
