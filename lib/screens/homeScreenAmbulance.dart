import 'package:flutter/material.dart';
import 'package:sal_maps/helper/constants.dart';
import 'package:sal_maps/helper/utilities.dart';

import '../model/request.dart';

class HomePageAmbulance extends StatefulWidget {
  const HomePageAmbulance({Key? key}) : super(key: key);

  @override
  _HomePageAmbulanceState createState() => _HomePageAmbulanceState();
}


class _HomePageAmbulanceState extends State<HomePageAmbulance> {

  // ambulanceRequested = true;
  runForever() async {
    bool x;
    while(true) {
      print("running");
      x = await RequestService.confirmService("Ambulance");
      ambulanceRequested = true;
      break;
    }
    if(ambulanceRequested) {
      var result = await RequestService.sendServiceLocation();
      eta = result["eta"];
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Image(
                image: AssetImage(
                  'assets/icon/sihlogo.png',
                ),
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              // Login
              const Text(
                'Home For Emergency Services',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 32,),
              ambulanceRequested?Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.orange
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        'User Requesting Service',
                      style: TextStyle(
                        fontSize: 24
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('cancel tapped');
                          },
                          child: Container(
                            height: 40,
                            width: 160,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('confirm tapped');
                            double lat = globalLoc["lat"]??12.9767;
                            double lng = globalLoc["lng"]??77.5713;
                            MapUtils.openMap(lat, lng);
                          },
                          child: Container(
                            height: 40,
                            width: 160,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
}
