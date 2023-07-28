class AddAdsRequest {
  String? amount;
  String? name;
  String? comment;
  String? image;
  String? token;
  String? catid;
  AddAdsRequest({
    this.amount,
    this.catid,
    this.comment,
    this.image,
    this.name,
    this.token,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'amount': amount!.trim(),
      'name': name!.trim(),
      'comment': comment!.trim(),
      'catid': catid!.trim(),
      'image': image!.trim(),
      'token': token!.trim(),
    };
    return map;
  }
}

class AddAdsResponse {
  String? msg;
  String? code;

  AddAdsResponse({
    this.msg,
    this.code,
  });

  factory AddAdsResponse.fromJson(Map<String, dynamic> json) {
    return AddAdsResponse(
      msg: json['msg'],
      code: json['code'],
    );
  }
}
