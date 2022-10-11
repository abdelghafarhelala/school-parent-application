class ContactModel {
  bool? result;
  String? errorMessage;
  String? errorMessageEn;
  String? data;

  ContactModel(
      {this.result, this.errorMessage, this.errorMessageEn, this.data});

  ContactModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    errorMessage = json['success_message'];
    errorMessageEn = json['success_message_en'];
    data = json['data'];
  }
}
