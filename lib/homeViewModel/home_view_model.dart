import 'package:ecommerce/ViewModels/ads_view_model.dart';
import 'package:ecommerce/ViewModels/categories_viewmodel.dart';
import 'package:ecommerce/ViewModels/main_view_model.dart';
import 'package:ecommerce/data/ads_api.dart';
import 'package:ecommerce/data/sub_cat_api.dart';
import 'package:flutter/material.dart';
import '../ViewModels/subcat_view_model.dart';
import '../data/categories_api.dart';
import '../data/main_api.dart';
import '../models/ads_model.dart';
import '../models/categories_model.dart';
import '../models/main_model.dart';
import '../models/subcat_model.dart';

class HomeViewModel extends ChangeNotifier {
  //variables
  MainViewModel? mainData;
  List<String>? listBannerImages;
  List<CategoriesViewModel>? listCategories;
  SubCategoryViewModel? listsubCategory;
  AdsViewModel? adsData;

//functions
  // list Banner Images
  Future<void> fetchMainData() async {
    MainModel jsonMap = await getMainData();
    mainData = MainViewModel(mainModel: jsonMap);
    //banner
    listBannerImages = mainData!.bannerImages;

    notifyListeners();
  }

  //list Categoriesd
  Future<void> fetchCategories() async {
    List<CategoriesModel> jsonMap = await getCategoriesInfo();
    listCategories =
        jsonMap.map((e) => CategoriesViewModel(categoriesModel: e)).toList();

    notifyListeners();
  }

  //list Categoriesd
  Future<void> fetchSubCategory({required int id}) async {
    SubCatModel jsonMap = await getSubCategory(id: id);
    listsubCategory = SubCategoryViewModel(subcategoryModel: jsonMap);

    notifyListeners();
  }

  //get ads data
  Future<void> fetchAds({required int id}) async {
    AdsModel jsonMap = await getAdsData(id: id);
    adsData = AdsViewModel(adsModel: jsonMap);
    notifyListeners();
  }
}
