
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/core/utlis/api_constatns.dart';
import 'package:taxi/core/utlis/app_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domin/entities/user.dart';
import '../../persentaion/ui/login_screen/login_screen.dart';





printFunction(message) {
  // ignore: avoid_print
  print(message);
}
pop(context) {
  Navigator.of(context).pop();
}

pushPage({context, page}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}


// getDataUser(){
//   ShardEditor editor=ShardEditor();
//   editor.getUser().then((value) {
//
//     currentUser = value;
//     token=value.token!;
//     printFunction("cerrentUser${currentUser.token}");
//   });
// }

bool isLogin(){

  return AppModel.token != "";
}



readToken() async {
  // await getBaseUrl();
  const storage =  FlutterSecureStorage();
  try {

    AppModel.lang=(await storage.read(key: "lang"))!;
    currentUser.token = (await storage.read(key: "token"))!;
    currentUser.id=( await storage.read(key: "id"));
    currentUser.role=( await storage.read(key: "role"));
    currentUser.fullName=( await storage.read(key: "name"));
    currentUser.profileImage=( await storage.read(key: "image"));
    printFunction("token : ${currentUser.id!}");
  } catch (e) {}
}
//
isRegistered() {
  return ( currentUser.token != "");
}

saveToken() {
  const storage =  FlutterSecureStorage();
  storage.write(key: 'token', value:  currentUser.token);
  storage.write(key: 'id', value: currentUser.id);
  storage.write(key: 'role', value: currentUser.role);
  storage.write(key: 'image', value: currentUser.profileImage);
  storage.write(key: 'name', value: currentUser.fullName);
}
saveData(key , value) async{
  const storage =  FlutterSecureStorage();
  storage.write(key: key, value:  value);


}

late String currentLocal;
LocationData locData = LocationData.fromMap({});
getLocation() async {
  Location location =  Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locData = await location.getLocation();
  print("${locData.latitude} lat:${locData.longitude} LNG:");
}

signOut({ctx}) async {
  const storage = FlutterSecureStorage();

  currentUser.token = "";
  await storage.delete(key: "token");
  // await storage.delete(key: "id");
  replacePage(context: ctx, page:  LoginScreen());
}


// int createUniqueId() {
//   return DateTime.now().millisecondsSinceEpoch.remainder(100000);
// }

// // luncher
// Future luncherUrl (url)async{
// if (!await launchUrl(url)) {
//     throw 'Could not launch $url';
//   }
// }
 

showSnakeBar({context,message}){
  final snackBar = SnackBar(
    content:  Text(message,style: TextStyle(fontSize: 12,color: Colors.white),),
    backgroundColor: Colors.red,
    action: SnackBarAction(
      label: '',
      textColor:Colors.transparent,
      onPressed: () {

      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showToast({message}){
  Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );
}

// Future showDialogAction(BuildContext context,bool load,{name,type,onTap}) async {
//   showDialog(
//     context: context,
//     builder: (context) {
//       // return object of type Dialog
//       return AlertDialog(
//         title: Texts(
//             fSize: 18,
//             color: Colors.red,
//             title: name,
//             weight: FontWeight.bold),
//         content: Texts(
//             fSize: 18,
//             color: Colors.black,
//             title: "هل أنت متأكد من أنك تريد حذف هذا $type",
//             weight: FontWeight.bold),
//         actions: <Widget>[
//           // usually buttons at the bottom of the dialog
//           load?const Center(
//             child: CircularProgressIndicator(
//               color: homeColor,
//               strokeWidth: 3,
//             ),
//           ):    TextButton(
//             onPressed: onTap,
//             child: const Text("حذف", style: TextStyle(color: Colors.red)),
//           ),
//           TextButton(
//             child: const Text("الغاء"),
//             onPressed: () {
//               Navigator.pop(context, 0);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
openGoogleMapLocation({lat, lng}) async {
    String mapOptions = [
      'saddr=${locData.latitude},${locData.longitude}',
      'daddr=$lat,$lng',
      'dir_action=navigate'
    ].join('&');

    String url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
