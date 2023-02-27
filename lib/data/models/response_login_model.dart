import 'package:taxi/domin/entities/response_login.dart';

class ResponseLoginModel extends ResponseLogin {
  ResponseLoginModel({required super.status, required super.code});

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      ResponseLoginModel(status: json["status"], code: json["code"]);
}
