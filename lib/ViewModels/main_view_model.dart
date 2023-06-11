import '../models/main_model.dart';

class MainViewModel {
  final MainModel _mainModel;
  MainViewModel({required MainModel mainModel}) : _mainModel = mainModel;

  //Banner

  List<String>? get bannerImages {
    List<String> urlImages = [];
    if (_mainModel.banners!.isNotEmpty) {
      for (int i = 0; i < _mainModel.banners!.length; i++) {
        urlImages.add(_mainModel.banners![i].image!);
      }
    }
    return urlImages;
  }

  //Ads

  int? get adsLenght {
    return _mainModel.ads!.length;
  }

  List<int>? get adsId {
    List<int> adsid = [];
    if (_mainModel.ads!.isNotEmpty) {
      for (int i = 0; i < _mainModel.ads!.length; i++) {
        adsid.add(_mainModel.ads![i].id!);
      }
    }
    return adsid;
  }

  List<String>? get adstitle {
    List<String> adsTitle = [];
    if (_mainModel.ads!.isNotEmpty) {
      for (int i = 0; i < _mainModel.ads!.length; i++) {
        adsTitle.add(_mainModel.ads![i].title!);
      }
    }
    return adsTitle;
  }

  List<String>? get adsImages {
    List<String> adsImages = [];
    if (_mainModel.ads!.isNotEmpty) {
      for (int i = 0; i < _mainModel.ads!.length; i++) {
        adsImages.add(_mainModel.ads![i].image!);
      }
    }
    return adsImages;
  }

  List<String>? get adsCreated {
    List<String> adsCreated = [];
    if (_mainModel.ads!.isNotEmpty) {
      for (int i = 0; i < _mainModel.ads!.length; i++) {
        adsCreated.add(_mainModel.ads![i].created!);
      }
    }
    return adsCreated;
  }

  List<String>? get adsPrice {
    List<String> adsPrice = [];
    if (_mainModel.ads!.isNotEmpty) {
      for (int i = 0; i < _mainModel.ads!.length; i++) {
        adsPrice.add(_mainModel.ads![i].price!);
      }
    }
    return adsPrice;
  }

  List<String>? get adsDesc {
    List<String> adsdesc = [];
    if (_mainModel.ads!.isNotEmpty) {
      for (int i = 0; i < _mainModel.ads!.length; i++) {
        adsdesc.add(_mainModel.ads![i].desc!);
      }
    }
    return adsdesc;
  }

  List<String>? get adsUserId {
    List<String> adsuserId = [];
    if (_mainModel.ads!.isNotEmpty) {
      for (int i = 0; i < _mainModel.ads!.length; i++) {
        adsuserId.add(_mainModel.ads![i].userId!);
      }
    }
    return adsuserId;
  }
}
