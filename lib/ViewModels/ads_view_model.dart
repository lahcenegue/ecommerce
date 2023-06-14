import 'package:ecommerce/models/ads_model.dart';

class AdsViewModel {
  final AdsModel _adsModel;
  AdsViewModel({required AdsModel adsModel}) : _adsModel = adsModel;

  int? get id {
    return _adsModel.id;
  }

  String? get title {
    return _adsModel.title;
  }

  List<String>? get images {
    List<String> listImages = [];
    if (_adsModel.images!.isNotEmpty) {
      for (int i = 0; i < _adsModel.images!.length; i++) {
        listImages.add(_adsModel.images![i].toString());
      }
    }
    return listImages;
  }

  String? get created {
    return _adsModel.created;
  }

  String? get price {
    return _adsModel.price;
  }

  String? get desc {
    return _adsModel.desc;
  }

  String? get userId {
    return _adsModel.userId;
  }

  String? get type {
    return _adsModel.type;
  }

  String? get color {
    return _adsModel.color;
  }
}
