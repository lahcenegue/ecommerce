class RegisterRequestModel {
  String? name;
  String? email;
  String? password;

  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
    };

    return map;
  }
}

class RegisterResponseModel {
  String? msg;
  String? user;
  String? name;
  String? token;

  RegisterResponseModel({
    this.msg,
    this.user,
    this.name,
    this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      msg: json['msg'],
      user: json['user'],
      name: json['name'],
      token: json['token'],
    );
  }
}
