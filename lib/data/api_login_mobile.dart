import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../core/utils/app_links.dart';
import '../core/widgets/one_signal_controller.dart';
import '../models/login_mobile_model.dart';

Future<LoginMobileModel> apiLoginMobile(String phone) async {
  try {
    var url = Uri.parse(
        "${AppLinks.mainLink}/${AppLinks.login}/${OneSignalControler.osUserID}/$phone");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var body = convert.jsonDecode(response.body);

      LoginMobileModel loginMobileModel = LoginMobileModel.fromJson(body);

      return loginMobileModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return LoginMobileModel();
}
