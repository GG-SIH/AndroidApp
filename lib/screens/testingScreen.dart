import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/main.dart';

import '../helper/notifications.dart';
import 'emergencyServices.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({Key? key}) : super(key: key);

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {

  @override
  void initState() {
    super.initState();
    setUpNotificationPermissions(context);
    notificationCreationStream(context);
    notificationActionStream(context);
  }
  @override
  void dispose() {
    super.dispose();
    disposeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('Testing'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          width: 150,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: GestureDetector(
            onTap: () async {
              if (kDebugMode) {
                print('Testing Screen Button Presses');
              }
              await createNotification().then((value) => print("Done Noti"));
              // await playLocalAsset();
            },
            child: Container(
              alignment: Alignment.center,
              child: const Text('Do not press it !!',style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
