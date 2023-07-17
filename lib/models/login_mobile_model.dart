class LoginMobileModel {
  String? msg;
  String? code;

  LoginMobileModel({
    this.msg,
    this.code,
  });

  factory LoginMobileModel.fromJson(Map<String, dynamic> json) {
    return LoginMobileModel(
      msg: json['msg'],
      code: json['code'],
    );
  }
}
