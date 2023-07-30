class UpdateProfilRequestModel {
  String? email;
  String? info;
  UpdateProfilRequestModel({
    this.email,
    this.info,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email!.trim(),
      'info': info!.trim(),
    };
    return map;
  }
}

class UpdateProfilResponseModel {
  String? edit;
  String? msg;
  String? email;
  String? info;

  UpdateProfilResponseModel({
    this.edit,
    this.email,
    this.info,
    this.msg,
  });

  factory UpdateProfilResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfilResponseModel(
      edit: json['edit'],
      msg: json['msg'],
      email: json['email'],
      info: json['info'],
    );
  }
}

class GetInfoModel {
  String? msg;
  String? email;
  String? info;

  GetInfoModel({
    this.email,
    this.info,
    this.msg,
  });

  factory GetInfoModel.fromJson(Map<String, dynamic> json) {
    return GetInfoModel(
      msg: json['msg'],
      email: json['email'],
      info: json['info'],
    );
  }
}
