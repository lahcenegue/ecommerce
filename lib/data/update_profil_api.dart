import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

import '../core/utils/app_links.dart';
import '../models/update_profil_model.dart';

Future<UpdateProfilResponseModel> apiUpdateProfil(
    {required UpdateProfilRequestModel updateProfilRequestModel,
    required String token}) async {
  try {
    var url = Uri.parse("${AppLinks.mainLink}/${AppLinks.profil}?token=$token");
    http.Response response = await http.post(
      url,
      body: updateProfilRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      UpdateProfilResponseModel updateProfilResponseModel =
          UpdateProfilResponseModel.fromJson(body);

      return updateProfilResponseModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return UpdateProfilResponseModel();
}
