import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/screens/emergencyServices.dart';
import 'package:sal_maps/screens/login.dart';
import 'package:sal_maps/screens/loginWithGoogleScreen.dart';
import 'package:sal_maps/screens/mapScreen.dart';
import 'package:sal_maps/screens/splashScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:sal_maps/screens/testingScreen.dart';
import 'package:sal_maps/screens/tracking.dart';
import 'package:audioplayers/audioplayers.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      'resource://drawable/res_notification_app_icons',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'While Driving Notification',
          channelDescription: 'Basic Notifications while driving Required!!',
          defaultColor: Colors.blue,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          soundSource: 'resource://raw/res_custom_notification',
        )
      ]
  );
  // await playLocalAsset();
  runApp(MyApp());
}

Future<void> playLocalAsset() async {
  print("in audio");
  final player = AudioPlayer();
  // final AudioCache _audioCache = AudioCache(
  //   prefix: 'audio/',
  // );
  // _audioCache.
  //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
  //Just pass the file name only.
  await player.setSource(AssetSource('audio/make_way.mpeg')).then((value) =>
  {print("played")});
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
      // home: MapScreen(),
      // home: SignInGoogle(),
      // home: MapScreen(),
      // home: Tracking(),
      // home: TestingPage(),
      home: SplashScreen(),
    );
  }
}
