import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../core/utils/app_links.dart';
import '../models/profil_model.dart';

Future<ProfilModel> profilApi({required String token}) async {
  try {
    var url =
        Uri.parse("${AppLinks.mainLink}/${AppLinks.profil}/?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      ProfilModel profilModel = ProfilModel.fromJson(body);

      return profilModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return ProfilModel();
}
