import 'package:taxi/domin/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.fullName,
      required super.userName,
      required super.profileImage,
      required super.role,
      required super.token,
        required super.email,
        required super.points,
      required super.deviceToken});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      token: json["token"]??"",
      id: json["user"]["id"],
      fullName: json["user"]["fullName"],
      userName: json["user"]["userName"],
      email: json["user"]["email"],
      profileImage: json["user"]["profileImage"]??"",
      role: json["user"]["role"],
       points: json["user"]["points"].toDouble(),
      deviceToken: json["user"]["deviceToken"]);
}
