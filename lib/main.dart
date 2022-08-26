import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/screens/emergencyServices.dart';
import 'package:sal_maps/screens/login.dart';
import 'package:sal_maps/screens/loginWithGoogleScreen.dart';
import 'package:sal_maps/screens/mapScreen.dart';
import 'package:sal_maps/screens/splashScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'While Driving Notification',
          channelDescription: 'Basic Notifications while driving Required!!',
          defaultColor: Colors.blue,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
        )
      ]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAL_Maps',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // home: LoginPage(),
      home: SplashScreen(),
      // home: SignInGoogle(),
      // home: MapScreen(),
    );
  }
}
