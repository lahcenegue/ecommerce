import 'package:ecommerce/ViewModels/ads_view_model.dart';
import 'package:ecommerce/ViewModels/categories_viewmodel.dart';
import 'package:ecommerce/ViewModels/main_view_model.dart';
import 'package:ecommerce/data/ads_api.dart';
import 'package:flutter/material.dart';
import '../data/categories_api.dart';
import '../data/main_api.dart';
import '../models/ads_model.dart';
import '../models/categories_model.dart';
import '../models/main_model.dart';

class HomeViewModel extends ChangeNotifier {
  //variables
  MainViewModel? mainData;
  List<String>? listBannerImages;
  int? adsLenght;
  List<int>? listAdsId;
  List<String>? listAdsTitle;
  List<String>? listAdsImages;
  List<String>? listAdsCreated;
  List<String>? listAdsPrice;
  List<String>? listAdsDesc;
  List<String>? listAdsUserId;
  //categories
  List<CategoriesViewModel>? listCategories;
  //ads
  AdsViewModel? adsData;

//functions
  // list Banner Images
  Future<void> fetchMainData() async {
    MainModel jsonMap = await getMainData();
    mainData = MainViewModel(mainModel: jsonMap);
    //banner
    listBannerImages = mainData!.bannerImages;
    //ads
    adsLenght = mainData!.adsLenght;
    listAdsId = mainData!.adsId;
    listAdsTitle = mainData!.adstitle;
    listAdsImages = mainData!.adsImages;
    listAdsCreated = mainData!.adsCreated;
    listAdsPrice = mainData!.adsPrice;
    listAdsDesc = mainData!.adsDesc;
    listAdsUserId = mainData!.adsUserId;

    notifyListeners();
  }

  //list Categoriesd
  Future<void> fetchCategories() async {
    List<CategoriesModel> jsonMap = await getCategoriesInfo();
    listCategories =
        jsonMap.map((e) => CategoriesViewModel(categoriesModel: e)).toList();

    notifyListeners();
  }

  //get ads data
  Future<void> fetchAds({required int id}) async {
    AdsModel jsonMap = await getAdsData(id: id);
    adsData = AdsViewModel(adsModel: jsonMap);
    notifyListeners();
  }
}
