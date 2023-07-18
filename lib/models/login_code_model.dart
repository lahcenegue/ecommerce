class LoginCodeModel {
  String? msg;
  String? code;
  String? user;
  String? name;
  String? token;

  LoginCodeModel({
    this.msg,
    this.code,
    this.user,
    this.name,
    this.token,
  });

  factory LoginCodeModel.fromJson(Map<String, dynamic> json) {
    return LoginCodeModel(
      msg: json['msg'],
      code: json['code'],
      user: json['user'],
      name: json['name'],
      token: json['token'],
    );
  }
}
