import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../core/utils/app_links.dart';
import '../core/widgets/one_signal_controller.dart';
import '../models/register_response_model.dart';

Future<RegisterResponseModel> apiRegister({
  required String phone,
  required String yourCode,
  required RegisterRequestModel registerRequestModel,
}) async {
  RegisterResponseModel responseModel = RegisterResponseModel();

  try {
    var url = Uri.parse(
        "${AppLinks.mainLink}/${AppLinks.login}/${OneSignalControler.osUserID}/$phone/$yourCode/reg");
    http.Response response = await http.post(
      url,
      body: registerRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      var body = convert.json.decode(response.body);

      responseModel = RegisterResponseModel.fromJson(body);

      return responseModel;
    }
  } catch (e) {
    throw Exception(e);
  }
  return responseModel;
}
