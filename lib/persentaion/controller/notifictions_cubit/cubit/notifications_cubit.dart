import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import '../../../../core/utlis/api_constatns.dart';
import '../../../../core/utlis/app_model.dart';
import '../../../../core/utlis/enums.dart';
import '../../../../data/models/notification.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState());

  static NotificationsCubit get(context) =>
      BlocProvider.of<NotificationsCubit>(context);

  getNotifications() async {
    emit(NotificationsState(getNotificationsState: RequestState.loading));
    var request = http.Request(
        'GET', Uri.parse(ApiConstants.getNotificationsPath + currentUser.id!));

    http.StreamedResponse response = await request.send();

 print(response.statusCode.toString() + " ====>getNotifications");
    if (response.statusCode == 200) {
      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

     
      List<NotificationModel> notifications = [];
      jsonData.forEach((element) {
        notifications.add(NotificationModel.fromJson(element));
      });
      // jsonData.fo
      // Notification driverModel = Notification.fromJson(jsonData);

      emit(NotificationsState(
          getNotificationsState: RequestState.loaded,
          notifications: notifications));
    } else {
      emit(NotificationsState(getNotificationsState: RequestState.error));
    }
  }
}
