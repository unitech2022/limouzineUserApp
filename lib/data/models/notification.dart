class NotificationModel {
  int? id;
  String? userId;
  String? title;
  String? body;
  String? titleEng;
  String? bodyEng;
  String? modelId;
  int? isRead;
  String? date;

  NotificationModel(
      {this.id,
      this.userId,
      this.title,
      this.body,
      this.titleEng,
      this.bodyEng,
      this.modelId,
      this.isRead,
      this.date});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    body = json['body'];
    titleEng = json['titleEng'];
    bodyEng = json['bodyEng'];
    modelId = json['modelId'];
    isRead = json['isRead'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['body'] = this.body;
    data['titleEng'] = this.titleEng;
    data['bodyEng'] = this.bodyEng;
    data['modelId'] = this.modelId;
    data['isRead'] = this.isRead;
    data['date'] = this.date;
    return data;
  }
}
