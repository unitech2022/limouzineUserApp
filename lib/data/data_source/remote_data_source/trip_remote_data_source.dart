import 'dart:convert';

import 'package:taxi/data/models/car_type_model.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/data/models/rsponse_home.dart';
import 'package:taxi/data/models/trip_model.dart';
import 'package:taxi/domin/entities/trip.dart';

import '../../../core/network/error_message_model.dart';
import '../../../core/utlis/api_constatns.dart';

abstract class BaseTripRemoteDataSource {
  Future<List<CarTypeModel>> getCarTypes();
  Future<TripModel> addTrip(Trip trip);

  Future<ResponseHome> homeTrip({userId});
}

class TripRemoteDataSource extends BaseTripRemoteDataSource {
  @override
  Future<List<CarTypeModel>> getCarTypes() async {
    var request = http.Request('GET', Uri.parse(ApiConstants.getCarTypesPath));

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "sssss");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      return List<CarTypeModel>.from(
          (jsonData as List).map((e) => CarTypeModel.fromJson(e)));
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }

  @override
  Future<TripModel> addTrip(Trip trip) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiConstants.addTripPath));
    request.fields.addAll({
      'driverId': "0",
      'carId': trip.carId.toString(),
      'price': trip.price.toString(),
      'userId': trip.userId,
      'startPointLat': trip.startPointLat.toString(),
      'startPointLng': trip.startPointLng.toString(),
      'endPointLat': trip.endPointLat.toString(),
      'endPointLng': trip.endPointLng.toString(),
      'startAddress': trip.startAddress,
      'endAddress': trip.endAddress,
      'OTP': trip.otp,
      'payment': '0'
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString() + "sssss");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      return TripModel.fromJson(jsonData);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }



  @override
  Future<ResponseHome> homeTrip({userId}) async {
    var request =
        http.MultipartRequest('GET', Uri.parse(ApiConstants.homeTripsPath));
    request.fields.addAll({'userId': userId});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      return ResponseHome.fromJson(jsonData);
    } else {
      throw ErrorMessageModel(
          statusCode: response.statusCode,
          statusMessage: "حدث خطأ, حاول مرة أخرى");
    }
  }
}
