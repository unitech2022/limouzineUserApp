

class UserDetail {
  String? id;
  String? fullName;
  String? userName;
  String? email;
  String? profileImage;
  String? role;
  String? deviceToken;
  String? status;
  String? code;

  String? points;
  String? surveysBalance;
  String? createdAt;

  UserDetail(
      {this.id,
      this.fullName,
      this.userName,
      this.email,
      this.profileImage,
      this.role,
      this.deviceToken,
      this.status,
      this.code,
      this.points,
      this.surveysBalance,
      this.createdAt});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['userName'];
    email = json['email'];
    profileImage = json['profileImage'];
    role = json['role'];
    deviceToken = json['deviceToken'];
    status = json['status'];
    code = json['code'];
  
    points = json['points'];
    surveysBalance = json['surveysBalance'];
    createdAt = json['createdAt'];
  }

 
}

