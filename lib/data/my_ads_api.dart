import 'package:ecommerce/core/utils/app_links.dart';
import 'package:ecommerce/core/utils/cache_helper.dart';
import 'package:ecommerce/models/ads_model.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<AdsModel>> myAdsApi(
    {required String token, required int page}) async {
  try {
    Uri url =
        Uri.parse('${AppLinks.mainLink}/${AppLinks.myAds}/$page?token=$token');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.body == 'null') {
        CacheHelper.removeData(key: PrefKeys.token);
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
      } else {
        dynamic data = convert.jsonDecode(response.body);
        Iterable list = data;

        List<AdsModel> subCatAds =
            list.map((e) => AdsModel.fromJson(e)).toList();

        return subCatAds;
      }
    }
  } catch (e) {
    throw Exception(e);
  }

  return [];
}
