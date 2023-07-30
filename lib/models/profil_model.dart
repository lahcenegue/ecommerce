class ProfilModel {
  String? msg;
  String? info;
  String? email;
  String? phone;

  ProfilModel({
    this.msg,
    this.info,
    this.email,
    this.phone,
  });

  factory ProfilModel.fromJson(Map<String, dynamic> json) {
    return ProfilModel(
      msg: json['msg'],
      info: json['info'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}
