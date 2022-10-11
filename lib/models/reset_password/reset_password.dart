class ResetPasswordModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  ResetPasswordModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
