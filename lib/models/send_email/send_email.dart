class SendEmailModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  Data? data;

  SendEmailModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  SendEmailModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? password;
  String? token;

  Data({this.password, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    token = json['token'];
  }
}
