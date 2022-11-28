import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/helper/utilities.dart';
import 'package:sal_maps/screens/mapScreen.dart';

void setUpNotificationPermissions(BuildContext context) {
  AwesomeNotifications().isNotificationAllowed().then( (isAllowed) {
    if(!isAllowed) {
      if (kDebugMode) {
        print("Notification not Allowed asking for permission");
      }
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text('Allow Notifications'),
        content: const Text('Our app would send you notifications !'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Don\'t Allow',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              )),
          TextButton(
              onPressed: () {
                AwesomeNotifications()
                    .requestPermissionToSendNotifications().then((_) => Navigator.pop(context));
              },
              child: const Text(
                'Allow',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
        ],
      ),
      );
    } else {
      if (kDebugMode) {
        print("Notification Allowed!!");
      }
    }
  }).asStream().asBroadcastStream();
}

Future<void> createNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'basic_channel',
        title: 'Emergency service on the way',
        body: 'Please move to the left <-|',
        notificationLayout: NotificationLayout.BigText,
        // bigPicture: 'asset://assets/icon/sihlogo.png'
      )
  );
}

void notificationCreationStream(BuildContext context) {
  AwesomeNotifications().createdStream.listen(
          (notification) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
        SnackBar(
            content: Text('Notification Created on ${notification.channelKey}')
        )
    );
  });
}

void notificationActionStream(BuildContext context) {
  AwesomeNotifications().actionStream.listen(
          (notification) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => MapScreen()
                ),
                (route) => route.isFirst);
          });
}

void disposeNotification() {
  AwesomeNotifications().actionSink.close();
  AwesomeNotifications().createdSink.close();
}