import 'package:flutter/material.dart';

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
    // setUpNotificationPermissions(context);
    // notificationCreationStream(context);
    // notificationActionStream(context);
  }
  @override
  void dispose() {
    super.dispose();
    // disposeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Testing'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(24),
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: GestureDetector(
            onTap: () {
              print('Testing Screen Button Presses');
              createNotification();
            },
            child: Container(
              alignment: Alignment.center,
              child: Text('Do not press it !!',style: TextStyle(
                color: Colors.white
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
