
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:taxi/core/helpers/functions.dart';
import 'package:taxi/core/thems/them.dart';
import 'package:taxi/persentaion/controller/app_cubit/cubit/app_cubit.dart';
import 'package:taxi/persentaion/controller/auth_cubit/auth_cubit.dart';
import 'package:taxi/persentaion/controller/map_cubit%20copy/map_cubit.dart';
import 'package:taxi/persentaion/controller/notifictions_cubit/cubit/notifications_cubit.dart';
import 'package:taxi/persentaion/controller/trip_cubit/trip_cubit.dart';
import 'package:taxi/persentaion/ui/account_screen/account_screen.dart';
import 'package:taxi/persentaion/ui/add_address_screen/add_address_screen.dart';
import 'package:taxi/persentaion/ui/address_screen/address_screen.dart';
import 'package:taxi/persentaion/ui/history_screen/history_screen.dart';
import 'package:taxi/persentaion/ui/home_screen/home_screen.dart';
import 'package:taxi/persentaion/ui/home_screen/tabs_screens/start_trip_screen/start_trip_screen.dart';
import 'package:taxi/persentaion/ui/login_screen/login_screen.dart';
import 'package:taxi/persentaion/ui/notifications_screen/notifications_screen.dart';
import 'package:taxi/persentaion/ui/packages_screen/packages_screen.dart';
import 'package:taxi/persentaion/ui/payment_screens/add_payment_method/add_payment_,ethod_screen.dart';
import 'package:taxi/persentaion/ui/payment_screens/payment_methods_screen/payment_methods_screen.dart';
import 'package:taxi/persentaion/ui/payment_screens/payment_screen.dart';
import 'package:taxi/persentaion/ui/review_package_screen/review_package_screen.dart';
import 'package:taxi/persentaion/ui/settings_screen/settings_screen.dart';

import 'package:taxi/persentaion/ui/chose_lang_screen/chose_screen.dart';
import 'package:taxi/persentaion/ui/splash_screen/splash_screen.dart';
import 'package:taxi/persentaion/ui/welcome_screen/welcome_screen.dart';
import 'package:taxi/persentaion/ui/subscriptions_screen/subscriptions_screen.dart';

import 'core/routers/routers.dart';
import 'core/services/services_locator.dart';

// todo : handel select start address
// todo : problem select start point
// todo : when driver accepted  make refresh status in user

Future<void> _messageHandler(RemoteMessage message) async {

}
AndroidNotificationChannel? channel =
AndroidNotificationChannel("key1", "chat");

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async {

  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  await readToken();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp;
   await getLocation();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/translations",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: Phoenix(child: MyApp())),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white));

    // if (AppModel.lang == "") {
    //   EasyLocalization.of(context)?.setLocale(Locale("ar", ''));
    // } else {
    //   EasyLocalization.of(context)?.setLocale(Locale(AppModel.lang, ''));
    // }
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (BuildContext context) => sl<AppCubit>()),
        BlocProvider<AuthCubit>(create: (BuildContext context) => sl<AuthCubit>()),
         BlocProvider<TripCubit>(create: (BuildContext context) => sl<TripCubit>()),
          BlocProvider<NotificationsCubit>(
            create: (BuildContext context) => sl<NotificationsCubit>()),
              BlocProvider<MapCubit>(
            create: (BuildContext context) => sl<MapCubit>())
      ],
      child: BlocBuilder<AppCubit, AppState>(

        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme,
            initialRoute: splash,
            routes: {
              welcome: (context) => const WelcomeScreen(),
              splash: (context) => const SplashScreen(),
              lang: (context) => ChoseLangScreen(),
              login: (context) => LoginScreen(),
              // signUp: (context) => const SignUpScreen(),
              // otp: (context) => const OtpScreen(),
               notifications: (context) => NotificationsScreen(),
              home: (context) => StartTripScreen(),
              account: (context) => const AccountScreen(),
              history: (context) => HistoryScreen(),
              packages: (context) => PackagesScreen(),
              addAddress: (context) => AddAddressScreen(),
              address: (context) => AddressScreen(),
              review: (context) => ReviewPackageScreen(),
              payment: (context) => PaymentScreen(),
              addPayment: (context) => AddPaymentMethodScreen(),
              paymentMethods: (context) => PaymentMethodsScreen(),
              subscription: (context) => SubscriptionsScreen(),
              settings: (context) => SettingsScreen()
            },
          );
        },
      ),
    );
  }
}
