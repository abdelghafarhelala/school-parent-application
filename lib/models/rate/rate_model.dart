class RateModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;

  RateModel({
    this.result,
    this.errorMessage,
    this.errorMessageEn,
  });

  RateModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['error_message'];
    errorMessageEn = json['error_message_en'];
  }
}
