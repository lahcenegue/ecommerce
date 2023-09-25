import 'package:ecommerce/models/ads_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../core/utils/app_links.dart';

Future<List<AdsModel>> apiSearch({required String query}) async {
  try {
    var url = Uri.parse("${AppLinks.mainLink}/${AppLinks.search}=$query");
    print(
        '----------------------------------------------------------------------------');
    print(url);

    http.Response response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      var data = convert.jsonDecode(response.body);

      Iterable list = data;

      List<AdsModel> adsModel = list.map((e) => AdsModel.fromJson(e)).toList();

      return adsModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return [];
}
