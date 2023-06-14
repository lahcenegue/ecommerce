class AdsModel {
  int? id;
  String? title;
  List? images;
  String? created;
  String? price;
  String? desc;
  String? userId;
  String? type;
  String? color;

  AdsModel({
    this.id,
    this.title,
    this.images,
    this.created,
    this.price,
    this.userId,
    this.desc,
    this.type,
    this.color,
  });

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['ad_id'];
    title = json['ad_title'];
    images = json['imgs'];
    created = json['created_at'];
    price = json['price'];
    desc = json['ad_desc'];
    userId = json['user_id'];
    type = json['car_type'];
    color = json['car_color'];
  }
}
