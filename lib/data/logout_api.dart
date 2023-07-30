import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../core/utils/app_links.dart';
import '../core/widgets/one_signal_controller.dart';
import '../models/logout_model.dart';

Future<LogoutModel> logoutApi({required String token}) async {
  try {
    Uri url = Uri.parse(
        "${AppLinks.mainLink}/${AppLinks.logout}/${OneSignalControler.osUserID}?token=$token");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      LogoutModel logoutModel = LogoutModel.fromJson(body);

      return logoutModel;
    }
  } catch (e) {
    throw Exception(e);
  }

  return LogoutModel();
}
