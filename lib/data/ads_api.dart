import 'package:ecommerce/core/utils/app_links.dart';
import 'package:ecommerce/models/ads_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<AdsModel> getAdsData({required int id}) async {
  AdsModel? adsModel;
  try {
    Uri url = Uri.parse('${AppLinks.mainLink}/${AppLinks.adsPrefix}/$id');
    print(url);

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      adsModel = AdsModel.fromJson(data[0]);

      return adsModel;
    }
  } catch (e) {
    throw Exception(e);
  }

  return adsModel!;
}
