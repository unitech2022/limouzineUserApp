import 'package:dio/dio.dart';

import '../../../core/network/error_message_model.dart';
import '../../../core/utlis/api_constatns.dart';
abstract class BaseAppRemoteDataSource {
  Future<String> uploadImage({file});


}

class AppRemoteDataSource extends BaseAppRemoteDataSource {
  @override
  Future<String> uploadImage({file}) async {
    // TODO: implement uploadImage
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    final response =
        await Dio().post(ApiConstants.uploadImagesPath, data: data);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode!,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }
}

