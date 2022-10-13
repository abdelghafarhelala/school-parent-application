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
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? nationalId;
  double? latitude;
  double? longitude;
  String? image;
  String? gender;
  String? address;
  String? mobile;

  Data(
      {this.id,
      this.name,
      this.nationalId,
      this.latitude,
      this.longitude,
      this.image,
      this.gender,
      this.address,
      this.mobile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nationalId = json['national_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    gender = json['gender'];
    address = json['address'];
    mobile = json['mobile'];
  }
}
