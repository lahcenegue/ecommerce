class LoginCodeModel {
  String? msg;
  String? user;
  String? name;
  String? token;

  LoginCodeModel({
    this.msg,
    this.user,
    this.name,
    this.token,
  });

  factory LoginCodeModel.fromJson(Map<String, dynamic> json) {
    return LoginCodeModel(
      msg: json['msg'],
      user: json['user'],
      name: json['name'],
      token: json['token'],
    );
  }
}
