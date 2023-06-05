import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi/core/styles/colors.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import '../../domin/entities/city.dart';
import '../utlis/app_model.dart';
import '../utlis/strings.dart';
import 'functions.dart';

// pushPage(context, page) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => page),
//   );
// }

// pop(context) {
//   Navigator.pop(context);
// }

pushPageRoutName(context, route) {
  Navigator.pushNamed(
    context,
    route,
  );
}

showSheet(BuildContext context, child) {
  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return child;
    },
  );
}

pushPageRoutNameReplaced(context, route) {
  Navigator.pushReplacementNamed(
    context,
    route,
  );
}

widthScreen(context) => MediaQuery.of(context).size.width;

heightScreen(context) => MediaQuery.of(context).size.height;

SizedBox sizedHeight(double height) => SizedBox(
      height: height,
    );
SizedBox sizedWidth(double width) => SizedBox(
      width: width,
    );

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
void firebaseCloudMessaging_Listeners() {
  if (Platform.isIOS) {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  _firebaseMessaging.getToken().then((token) {
    AppModel.deviceToken = token!;
    print(AppModel.deviceToken);
  });
}

Future<void> showMyDialog({context, title, body, founction, child}) async {
  return showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          title,
          style: TextStyle(fontSize: 20, color: buttonsColor),
        ),
        content: Container(
          width: widthScreen(context),
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      body,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            color: homeColor,
            padding: EdgeInsets.all(5),
            child: Text(Strings.change.tr(),
                style: TextStyle(fontSize: 16, color: Colors.white)),
            onPressed: founction,
          ),
          MaterialButton(
            padding: EdgeInsets.all(5),
            color: Colors.red,
            child: Text(Strings.cancle.tr(),
                style: TextStyle(fontSize: 14, color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

showTopMessage({context, customBar}) {
  showTopSnackBar(
    Overlay.of(context),
    customBar,
  );
}

Future<void> getCities() async {
  final String response =
      await rootBundle.loadString('assets/jsons/cities.json');
  final data = await json.decode(response);
  cities = [];
  data.forEach((element) {
    cities.add(City.fromJson(element));
  });
}

Future subscribeToken() async {
  if (isRegistered()) {
    await FirebaseMessaging.instance.subscribeToTopic('user');
  }
}


DateTime MIN_DATETIME = DateTime.now().add(Duration(hours: 3)) ;
const String MAX_DATETIME = '2019-06-03 21:11:00';
DateTime INIT_DATETIME = DateTime.now().add(Duration(hours: 3));
void showDateTimePicker({context, onConfirm}) {
  DatePicker.showDatePicker(
    context,
    minDateTime:MIN_DATETIME,
    // maxDateTime: DateTime.parse(MAX_DATETIME),
    initialDateTime: INIT_DATETIME,
    dateFormat: 'dd MMMM yyyy HH:mm',
    locale: AppModel.lang == "ar"
        ? DateTimePickerLocale.ar_eg
        : DateTimePickerLocale.en_us,
        onMonthChangeStartWithFirstDate: true,
    pickerTheme: DateTimePickerTheme(
    
      

      showTitle: true,
    ),
    pickerMode: DateTimePickerMode.datetime, // show TimePicker
    onCancel: () {
      debugPrint('onCancel');
    },
    onChange: (dateTime, List<int> index) {},
    onConfirm: onConfirm,
  );
}
void showDateTimePicker2(context, {onConfirm}) {
  DateTime? dateAdded;
  showModalBottomSheet(
      context: context,
      // clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.white,
      // isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      use24hFormat: false,
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: INIT_DATETIME,
                      // minuteInterval: 30,
                      onDateTimeChanged: (date) {
                        dateAdded = date;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                            onPressed: () {
                              onConfirm(dateAdded);
                               
                            },
                            color: homeColor,
                            height: 50,
                            child: Text("اختيار".tr(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: MaterialButton(
                            onPressed: () {
                              pop(context);
                            },
                            color: Colors.red,
                            height: 50,
                            child: Text(
                              "الغاء".tr(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ));
      });
  ;
}

String formateDate({dateTime}) {
  final date =
      DateFormat('dd-MM-yyyy  HH:mm a', AppModel.lang).format(dateTime);
  return date.toString();
}