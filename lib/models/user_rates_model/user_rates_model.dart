class UserRatesModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  List<Data>? data;

  UserRatesModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  UserRatesModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['error_message'] = this.errorMessage;
    data['error_message_en'] = this.errorMessageEn;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? type;
  int? userId;
  int? ratedId;
  int? ratedInId;
  int? rate;
  int? rateApp;
  String? notes;
  String? isApproved;
  String? createdAt;
  String? updatedAt;
  String? userIp;
  String? userPcInfo;

  Data(
      {this.id,
      this.type,
      this.userId,
      this.ratedId,
      this.ratedInId,
      this.rate,
      this.rateApp,
      this.notes,
      this.isApproved,
      this.createdAt,
      this.updatedAt,
      this.userIp,
      this.userPcInfo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    ratedId = json['rated_id'];
    ratedInId = json['rated_in_id'];
    rate = json['rate'];
    rateApp = json['rate_app'];
    notes = json['notes'];
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userIp = json['user_ip'];
    userPcInfo = json['user_pc_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['rated_id'] = this.ratedId;
    data['rated_in_id'] = this.ratedInId;
    data['rate'] = this.rate;
    data['rate_app'] = this.rateApp;
    data['notes'] = this.notes;
    data['is_approved'] = this.isApproved;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_ip'] = this.userIp;
    data['user_pc_info'] = this.userPcInfo;
    return data;
  }
}
