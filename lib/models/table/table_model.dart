class TableModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  TableModel({this.result, this.errorMessage, this.errorMessageEn, this.data});

  TableModel.fromJson(Map<String, dynamic> json) {
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
  List<ClassesClassRoomSection>? classesClassRoomSection;

  Data({this.id, this.name, this.image, this.classesClassRoomSection});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['classes_class_room_section'] != null) {
      classesClassRoomSection = <ClassesClassRoomSection>[];
      json['classes_class_room_section'].forEach((v) {
        classesClassRoomSection!.add(ClassesClassRoomSection.fromJson(v));
      });
    }
  }
}

class ClassesClassRoomSection {
  int? id;
  int? sectionId;
  int? classId;
  int? teacherId;
  int? subjectId;
  String? day;
  String? deletedAt;
  String? updatedAt;
  String? createdAt;
  int? laravelThroughKey;
  Teacher? teacher;
  Subject? subject;
  Section? section;

  ClassesClassRoomSection(
      {this.id,
      this.sectionId,
      this.classId,
      this.teacherId,
      this.subjectId,
      this.day,
      this.deletedAt,
      this.updatedAt,
      this.createdAt,
      this.laravelThroughKey,
      this.teacher,
      this.subject,
      this.section});

  ClassesClassRoomSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    classId = json['class_id'];
    teacherId = json['teacher_id'];
    subjectId = json['subject_id'];
    day = json['day'];
    deletedAt = json['deleted_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    laravelThroughKey = json['laravel_through_key'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    section =
        json['section'] != null ? Section.fromJson(json['section']) : null;
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

  Subject({this.id, this.name, this.image});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Section {
  int? id;
  String? timeStart;
  String? timeEnd;

  Section({this.id, this.timeStart, this.timeEnd});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
  }
}
