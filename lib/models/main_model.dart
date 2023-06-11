class MainModel {
  List<BannerModel>? banners;
  List<AdsModel>? ads;
  MainModel({
    required this.banners,
    required this.ads,
  });

  MainModel.fromJson(Map<String, dynamic> json) {
    if (json['Banner'] != null) {
      banners = <BannerModel>[];
      json['Banner'].forEach(
        (v) {
          banners!.add(BannerModel.fromJson(v));
        },
      );
    }
    if (json['lastads'] != null) {
      ads = <AdsModel>[];
      json['lastads'].forEach(
        (v) {
          ads!.add(AdsModel.fromJson(v));
        },
      );
    }
  }
}

class BannerModel {
  String? image;
  int? id;

  BannerModel({
    required this.id,
    required this.image,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    image = json['img'];
    id = json['adld'];
  }
}

class AdsModel {
  int? id;
  String? title;
  String? image;
  String? created;
  String? price;
  String? desc;
  String? userId;

  AdsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.created,
    required this.price,
    required this.desc,
    required this.userId,
  });

  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['ad_title'];
    image = json['primary_img'];
    created = json['created_at'];
    price = json['price'];
    desc = json['desc'];
    userId = json['user_id'];
  }
}
