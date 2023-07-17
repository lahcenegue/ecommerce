import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'one_signal_controller.dart';

Future<void> checkNotification() async {
  late final PermissionStatus statusess;
  statusess = await Permission.notification.request();
  debugPrint('statuse : $statusess');
  OneSignalControler.inite();
}
