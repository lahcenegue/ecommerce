class LogoutModel {
  String? msg;
  String? logout;

  LogoutModel({
    this.msg,
    this.logout,
  });
  LogoutModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    logout = json['logout'];
  }
}
