import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../core/utils/app_links.dart';
import '../core/widgets/one_signal_controller.dart';
import '../models/login_code_model.dart';

Future<LoginCodeModel> apiLoginCode(String phone, yourCode) async {
  try {
    var url = Uri.parse(
        "${AppLinks.mainLink}/${AppLinks.login}/${OneSignalControler.osUserID}/$phone/$yourCode");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      LoginCodeModel loginCodeModel = LoginCodeModel.fromJson(body);

      return loginCodeModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return LoginCodeModel();
}
