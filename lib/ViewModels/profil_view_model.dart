import 'package:ecommerce/models/profil_model.dart';

class ProfilViewModel {
  final ProfilModel _profilModel;
  ProfilViewModel({required ProfilModel profilModel})
      : _profilModel = profilModel;

  String get msg {
    return _profilModel.msg!;
  }

  String get email {
    return _profilModel.email!;
  }

  String get info {
    return _profilModel.info!;
  }

  String get phone {
    return _profilModel.phone!;
  }
}
