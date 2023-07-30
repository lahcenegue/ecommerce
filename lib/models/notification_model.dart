class NotificationModel {
  String? title;
  String? time;
  String? comment;

  NotificationModel({
    this.title,
    this.time,
    this.comment,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    time = json['time'];
    comment = json['comment'];
  }
}
