class UpdateProfileModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  UpdateProfileModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? mobile;

  Data({this.id, this.name, this.email, this.mobile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
  }
}
