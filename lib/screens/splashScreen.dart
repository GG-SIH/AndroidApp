import 'dart:async';
import 'package:flutter/material.dart';

// import '../helper/notifications.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    var d=const Duration(seconds: 5);
    Timer(d,
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:(context) =>
                  const LoginPage(),
            )
        )
    );
    // setUpNotificationPermissions(context);
    // notificationCreationStream(context);
    // notificationActionStream(context);
  }

  @override
  void dispose() {
    // disposeNotification();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // backgroundColor:  const Color(0xeeeafcff),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/icon/splash.png")
              )
          ),
        ),
      ),
    );
  }
}
