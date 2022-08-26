import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// import '../model/directions.dart';
import '../helper/constants.dart';
import '../helper/notifications.dart';
import '../model/directionsDirectory.dart';
import '../services/location_services.dart';
import '../widgets/mapExtras.dart';

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  final Completer<GoogleMapController> _controller = Completer();
  bool _notify = false;

  TextEditingController _searchDestinationController = new TextEditingController();
  TextEditingController _searchSourceController = new TextEditingController();

  static LatLng sourceLocation = LatLng(13.0306 , 77.5649);
  static LatLng destinationLocation = LatLng(12.9237, 77.4987);
  static const LatLng iiitGwaliorLocation = LatLng(26.2495, 78.1741);

  List<LatLng> polylineCoordinates = [];

  LocationData? currentLocation;
  Map<String, dynamic> dataMap = {
    'latitude' : 13.0306,
    'longitude' : 77.5649,

  };
  @override
  void initState() {
    getCurrentLocation();
    // currentLocation = new LocationData.fromMap(dataMap);

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }

  void getCurrentLocation() async {

    Location location = Location();
    location.getLocation().then((value) {
      currentLocation = value;
      if(mounted){
        setState(() {});
      }
    });
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((event) async {
      print("Listening location change");
      _notify = await _startChecking();
      if(_notify) {
        createNotification();
      }
      currentLocation = event;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
              target: LatLng(
            event.latitude!,
            event.longitude!,
          ))
        ),
      );
      if(mounted){
        setState(() {});
      }
    });
  }

  Future<bool> _startChecking() async {
    // await Server.callServer("k_pnA_llxMn@DPCFKN{DASGC_@CeCMMBEFAPAf@Q?a@?ID@B@DKpBqAIGfAIrAMrBlALxFb@`AFKv@ATEtA?JpCp@jCl@|@RRJJTe@N[NMJMVvCz@vBp@rGpB|FlBfBj@xCx@lAXdD~@|Bn@hBb@jBf@jD~@c@j@|Bp@^JZOLOt@]NZTVpDxAl@Zh@ZPRLNt@`Ah@l@n@j@v@T~@N~@Bh@DB@BFp@D`@LVJDl@Bz@BHfAGxAKn@M|@e@REd@Az@ARTDP?ZMVWZOJ?^@PpAjDtArDpArCZp@JGDC?IKUUo@@[Z]PGp@Q~@AXBN@vCWHBN`AaBN");
    // double cLat = 13.01454;
    double cLat = currentLocation!.latitude!;
    // double cLng = 77.57093;
    double cLng = currentLocation!.longitude!;
    Map<String,dynamic> mp1 = await DirectionRepository.userWithinRadius(cLat, cLng, 0);
    Map<String,dynamic> mp2 = await DirectionRepository.userWithinRadius(cLat, cLng, 1);
    Map<String,dynamic> mp3 = await DirectionRepository.userWithinRadius(cLat, cLng, 1);
    Map<String,dynamic> mp4 = await DirectionRepository.userWithinRadius(cLat, cLng, 1);
    // print("check:"+mp.toString());
    // print("check:"+mp1.toString());
    return true;

  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = new PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    apiKey,
    PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude)
    );
    if(result.points.isNotEmpty) {
      print("In getPolyPoints Function");
      print(result);
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    if(mounted){
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {

    bool showBottomInfo = false;
    var threshold = 50;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: currentLocation == null
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: _searchSourceController,
                                decoration: InputDecoration(
                                  hintText: "Your Location",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                ),
                                onChanged: (value) {
                                  print(value);
                                },
                                // decoration: CommonStyles.textFieldStyle("Enter Destination"),
                              )),
                              // IconButton(
                              //     onPressed: () async {
                              //       // print("Search Destination tapped");
                              //       Map<String, dynamic> place= await LocationServices().getPlace(_searchSourceController.text);
                              //       // print("Place in search onTAP $place");
                              //       _goToPlace(place);// camera animate not working cz ur camera updater is something else;
                              //     },
                              //     icon: Icon(Icons.search)
                              // )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: _searchDestinationController,
                                decoration: InputDecoration(
                                  hintText: "Enter Destination",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                ),
                                onChanged: (value) {
                                  print(value);
                                },
                                // decoration: CommonStyles.textFieldStyle("Enter Destination"),
                              )),
                              IconButton(
                                  onPressed: () async {
                                    // print("Search Destination tapped");
                                    // Map<String, dynamic> place =
                                    //     await LocationServices().getPlace(
                                    //         _searchDestinationController.text);
                                    // print("Place in search onTAP $place");
                                    await _goToPlace(); // camera animate not working cz ur camera updater is something else;
                                  },
                                  icon: Icon(Icons.search))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 12.5),
                      markers: {
                        Marker(
                          markerId: MarkerId("source"),
                          position: sourceLocation,
                        ),
                        Marker(
                          markerId: MarkerId("current"),
                          position: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                        ),
                        Marker(
                            markerId: MarkerId("destination"),
                            position: destinationLocation),
                      },
                      polylines: {
                        Polyline(
                            polylineId: PolylineId("route"),
                            points: polylineCoordinates,
                            color: Colors.black,
                            width: 6)
                      },
                    ),
                  ),
                  Container(
                    child: AnimatedPositioned(
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 200),
                        left: 0,
                        // bottom: 0,
                        // bottom: -(height/3)+100,
                        bottom: !showBottomInfo ? 0 : -(height / 3) + 90,
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  print("Tapped");

                                  bool x= await _startChecking();
                                  print("tracking x="+x.toString());
                                  // showBottomInfo = !showBottomInfo;
                                  // setState(() {
                                  //   showBottomInfo = !showBottomInfo;
                                  // });
                                },
                                // onPanEnd: (details) {
                                //   if(details.velocity.pixelsPerSecond.dy>threshold) {
                                //     print(showBottomInfo);
                                //     this.setState(() {
                                //       showBottomInfo = false;
                                //     });
                                //   } else if(details.velocity.pixelsPerSecond.dy < -threshold) {
                                //     this.setState(() {
                                //       showBottomInfo = true;
                                //     });
                                //   }
                                // },
                                child: Container(
                                    child: Icon(Icons.arrow_drop_up,size: 24,))),
                            DrivingInfo(),
                          ],
                        )),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _goToPlace() async {
    if(_searchSourceController.text.isNotEmpty) {
      Map<String, dynamic> sourcePlace= await LocationServices().getPlace(_searchSourceController.text);
      final double sLat = sourcePlace['geometry']['location']['lat'];
      final double sLng = sourcePlace['geometry']['location']['lng'];
      sourceLocation =LatLng(sLat, sLng);
    } else {
      sourceLocation = currentLocation as LatLng;
    }

    if(_searchDestinationController.text.isNotEmpty) {
      Map<String, dynamic> sourcePlace= await LocationServices().getPlace(_searchDestinationController.text);
      final double sLat = sourcePlace['geometry']['location']['lat'];
      final double sLng = sourcePlace['geometry']['location']['lng'];
      destinationLocation =LatLng(sLat, sLng);
    } else {
      destinationLocation = LatLng(12.9237, 77.4987);
    }
    await getPolyPoints();
  }
}

/*
* GestureDetector(
              onPanEnd: (details) {
                if(details.velocity.pixelsPerSecond.dy>threshold) {
                  print(showBottomInfo);
                  this.setState(() {
                    showBottomInfo = false;
                  });
                } else if(details.velocity.pixelsPerSecond.dy < -threshold) {
                  this.setState(() {
                    showBottomInfo = true;
                  });
                }
              },
              child: */
