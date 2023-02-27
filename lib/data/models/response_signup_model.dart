
import 'package:taxi/domin/entities/response_signup.dart';

class ResponseSignUpModel extends ResponseSignUp {
  ResponseSignUpModel({required super.status, required super.message});

  factory ResponseSignUpModel.fromJson(Map<String, dynamic> json) =>
      ResponseSignUpModel(status: json["status"], message: json["message"]);
}
