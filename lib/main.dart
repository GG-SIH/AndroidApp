import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/screens/emergencyServices.dart';
import 'package:sal_maps/screens/login.dart';
import 'package:sal_maps/screens/loginWithGoogleScreen.dart';
import 'package:sal_maps/screens/mapScreen.dart';
import 'package:sal_maps/screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      // home: EmergencyServices(),
    );
  }
}
