import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../utils/app_strings.dart';

class OneSignalControler {
  static String? osUserID = "";
  static Future<void> inite() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.Debug.setLogLevel(OSLogLevel.error);

    OneSignal.initialize(AppStrings.onSignalID);

    OneSignal.Notifications.clearAll();

    OneSignal.User.pushSubscription.addObserver((state) {
      // debugPrint(OneSignal.User.pushSubscription.optedIn.toString());
      // debugPrint(OneSignal.User.pushSubscription.id);
      // debugPrint(OneSignal.User.pushSubscription.token);
      debugPrint(state.current.jsonRepresentation());
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      debugPrint("Has permission $state");
    });

    osUserID = OneSignal.User.pushSubscription.id;
  }
}
