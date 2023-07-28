import 'package:ecommerce/models/add_ads.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../core/utils/app_links.dart';

Future<AddAdsResponse> addAdsApi({
  required AddAdsRequest addAdsRequest,
}) async {
  AddAdsResponse responseModel = AddAdsResponse();

  try {
    var url = Uri.parse("${AppLinks.mainLink}/${AppLinks.addAds}");

    http.Response response = await http.post(
      url,
      body: addAdsRequest.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.json.decode(response.body);

      responseModel = AddAdsResponse.fromJson(body);

      return responseModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return responseModel;
}
