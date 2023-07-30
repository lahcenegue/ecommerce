import '../models/notification_model.dart';

class NotificationViewModel {
  final NotificationModel _notificationModel;

  NotificationViewModel({required NotificationModel notificationModel})
      : _notificationModel = notificationModel;

  String get title {
    return _notificationModel.title!;
  }

  String get time {
    return _notificationModel.time!;
  }

  String get comment {
    return _notificationModel.comment!;
  }
}
