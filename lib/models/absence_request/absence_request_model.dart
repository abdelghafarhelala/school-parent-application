class AbsenceRequestModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;

  AbsenceRequestModel({this.result, this.errorMessage, this.errorMessageEn});

  AbsenceRequestModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
  }
}
