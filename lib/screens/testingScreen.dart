import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/main.dart';

import '../helper/notifications.dart';
import '../model/directions.dart';
import '../model/directionsDirectory.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                width: 150,
                height: 40,
                decoration: const BoxDecoration(color: Colors.black),
                child: GestureDetector(
                  onTap: () async {
                    if (kDebugMode) {
                      print('Testing Screen Button Presses');
                    }
                    await createNotificationMakeWay()
                        .then((value) => print("Done Noti"));
                    // await playLocalAsset();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Do not press it !!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.all(24),
                width: 150,
                height: 40,
                decoration: BoxDecoration(color: Colors.black),
                child: GestureDetector(
                  onTap: () async {
                    if (kDebugMode) {
                      print('Testing Screen Button Presses');
                    }
                    await createNotificationGetReady()
                        .then((value) => print("Done Noti"));
                    // await playLocalAsset();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Do not press it !!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: const EdgeInsets.all(24),
                width: 150,
                height: 40,
                decoration: BoxDecoration(color: Colors.black),
                child: GestureDetector(
                  onTap: () async {
                    print('3rd testing btn');
                    // await Server.callServer("k_pnA_llxMn@DPCFKN{DASGC_@CeCMMBEFAPAf@Q?a@?ID@B@DKpBqAIGfAIrAMrBlALxFb@`AFKv@ATEtA?JpCp@jCl@|@RRJJTe@N[NMJMVvCz@vBp@rGpB|FlBfBj@xCx@lAXdD~@|Bn@hBb@jBf@jD~@c@j@|Bp@^JZOLOt@]NZTVpDxAl@Zh@ZPRLNt@`Ah@l@n@j@v@T~@N~@Bh@DB@BFp@D`@LVJDl@Bz@BHfAGxAKn@M|@e@REd@Az@ARTDP?ZMVWZOJ?^@PpAjDtArDpArCZp@JGDC?IKUUo@@[Z]PGp@Q~@AXBN@vCWHBN`AaBN");
                    await Server.callServer("aeonA}~mxMex@|h@"); // users polyline object
                    // double cLat = 13.01454;
                    // double cLng = 77.57093;
                    double cLat1 = 13.0336; // ambulances location here
                    double cLng1 = 77.5688;
                    var mp = await DirectionRepository.userWithinRadius(cLat1, cLng1, 0);
                    var mp1 = await DirectionRepository.userWithinRadius(cLat1, cLng1, 1);
                    print("check:"+mp.toString());
                    print("check:"+mp1.toString());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Tracking thing here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
