
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/data/models/response_login_model.dart';
import 'package:taxi/data/models/response_signup_model.dart';
import 'package:taxi/data/models/user_model.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/utlis/api_constatns.dart';
import '../../../persentaion/ui/otp_screen/otp_screen.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> login({userName, deviceToken, code});

  Future<ResponseLoginModel> checkUserName({userName});

  Future<ResponseSignUpModel> signUp({user});
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<ResponseLoginModel> checkUserName(
      {userName, deviceToken, code}) async {
    // var params = {
    //   "userName": userName,
    // };
    //
    // final response = await Dio().post(ApiConstants.checkUserPath,
    //     data: params,
    //     options: Options(
    //       contentType: 'multipart/form-data',
    //       headers: {'Accept': "application/json"},
    //     ));

    var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.checkUserPath,));
    request.fields.addAll({
      "userName": userName,
    });


    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      return ResponseLoginModel.fromJson(jsonData);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<UserModel> login({userName, deviceToken, code}) async {


    var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.loginPath,));
    request.fields.addAll({"userName": userName,
      "deviceToken": "deviceToken",
      "code": "0000"});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      return UserModel.fromJson(jsonData);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<ResponseSignUpModel> signUp({user}) async{
    print(user);

    Map<String, String> params = {
      "userName": user.userName,
      "FullName": user.fullName,
      "Email": user.email,
      "Password": "Abc123",
      'Role': user.role,
      "ProfileImage": user.profileImage,
    };

    var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.signUpPath,));
    request.fields.addAll(params);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      return ResponseSignUpModel.fromJson(jsonData);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }
}