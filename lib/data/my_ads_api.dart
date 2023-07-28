import 'package:ecommerce/core/utils/app_links.dart';
import 'package:ecommerce/models/ads_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<AdsModel>> myAdsApi(
    {required String token, required int page}) async {
  try {
    Uri url =
        Uri.parse('${AppLinks.mainLink}/${AppLinks.myAds}/$page?token=$token');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);
      Iterable list = data;

      List<AdsModel> subCatAds = list.map((e) => AdsModel.fromJson(e)).toList();

      return subCatAds;
    }
  } catch (e) {
    throw Exception(e);
  }

  return [];
}
