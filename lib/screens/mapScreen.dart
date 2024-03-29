import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sal_maps/screens/emergencyServices.dart';
import 'package:sal_maps/screens/searchScreen.dart';
import 'package:sal_maps/screens/tracking.dart';

import '../helper/constants.dart';
import '../model/directions.dart';
import '../model/directionsDirectory.dart';
import '../services/getCurrentLocation.dart';
import '../services/location_services.dart';
import '../widgets/common_styles.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  bool _isLoading = true;

  TextEditingController searchDestinationController = TextEditingController();
  TextEditingController searchSourceController = TextEditingController();

  late Position _currentPosition;

  static const _initialCameraPosition = CameraPosition(
      target: LatLng(28.7163 , 77.1032 ),
      zoom: 14
  );

  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _googleMapController;
  Marker? _origin,_destination,_currentLocation;
  Directions? _info;

  @override
  initState() {
    super.initState();
    getCurrentLocation().then((value) {
      setState(() {
        _isLoading=false;
      });
    });
  }
  Future<void> getCurrentLocation() async {
    _currentPosition = await GeoLocatorServices.determineCurrentPosition();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    _currentLocation=null;
    _origin=null;
    _destination=null;

    super.dispose();
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
          position: pos,
        );
        _destination = null;
        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      final directions = await DirectionRepository().
      getDirections(origin: _origin!.position, destination: pos);
      // if(kDebugMode) {
      //   if (Server.mp.isNotEmpty) {
      //     print("radius=" + Server.mp["dynamic_radius"]);
      //   } else {
      //     print("radius=empty");
      //   }
      // }
      setState(() => _info = directions);
    }
  }

  CameraUpdate _setCurrentPositionAndMarker() {
    _currentLocation = Marker(
        markerId: const MarkerId('Current Location'),
        position: LatLng(_currentPosition.latitude,_currentPosition.longitude)
    );
    setState(() {});
    return CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_currentPosition.latitude,_currentPosition.longitude),
          zoom: 17,
        ));
  }

  Future<void> _goToPlace(Map<String ,dynamic> place) async {
    print("In goToPlace method");
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    if(searchSourceController.text.isNotEmpty) {
      // _origin = await LocationServices().getPlace(searchDestinationController.text);
      Map<String, dynamic> sourcePlace= await LocationServices().getPlace(searchSourceController.text);

      print(sourcePlace);
      final double sLat = sourcePlace['geometry']['location']['lat'];
      final double sLng = sourcePlace['geometry']['location']['lng'];
      LatLng sourcePos = new LatLng(sLat, sLng);
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen),
        position: sourcePos,
      );
      _destination = null;
      _info = null;
    } else {
      _origin = _currentLocation;
    }

    // final GoogleMapController controller = await _controller.future;
    print("In _goToPlace $lat lng = $lng");
    _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(lat,lng),
                zoom: 12
            )
        )
    );
    LatLng pos = new LatLng(lat, lng);
    // _origin = _currentLocation;

    _addMarker(pos);
    setState(() {});
  }

  // void

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Save A Life Maps"),
      // ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
            child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(1),
        child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: searchSourceController,
                        decoration: const InputDecoration(
                          hintText: "Your Location (Tap to change)",
                          hintStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen(s: "source",c: searchSourceController,)));
                        },
                        onChanged: (value) {
                          if (kDebugMode) {
                            print(value);
                          }
                        },
                        // decoration: CommonStyles.textFieldStyle("Enter Destination"),
                      )),

                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: searchDestinationController,
                        decoration: InputDecoration(
                          hintText: "Enter Destination",
                          hintStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        ),
                        // onTap: () async {
                        //
                        // },
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchScreen(s: "destination",c: searchDestinationController,)));
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        // decoration: CommonStyles.textFieldStyle("Enter Destination"),
                      )),
                  IconButton(
                      onPressed: () async {
                        // print("Search Destination tapped");
                        if(isAmbulanceDevice) {
                          Map<String, dynamic> place = {
                            'geometry' : {
                              'location' : {
                                'lat' : globalLoc["lat"],
                                'lng' : globalLoc["lng"]
                              }
                            }
                          };
                          print("Place in search onTAP Ambulance Side \n$place");
                          _goToPlace(place);
                        } else {
                          Map<String, dynamic> place =
                          await LocationServices().getPlace(
                              searchDestinationController.text);
                          print(searchDestinationController.text);
                          print("Place in search onTAP User Side \n$place");
                          _goToPlace(
                              place); // camera animate not working cz ur camera updater is something else;
                        }
                      },
                      icon: Icon(Icons.search))
                ],
              ),
              Expanded(
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _initialCameraPosition,
                  mapType: MapType.normal,
                  onMapCreated: (controller) =>
                  _googleMapController = controller,
                  markers: {
                    if (_origin != null) _origin!,
                    if (_destination != null) _destination!,
                    if (_currentLocation != null &&
                        _origin == null &&
                        _destination == null)
                      _currentLocation!
                  },
                  // onLongPress: _addMarker,
                  polylines: {
                    if (_info != null)
                      Polyline(
                        polylineId: const PolylineId('overview_polyline'),
                        color: Colors.red,
                        width: 5,
                        points: _info!.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList(),
                      ),
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Emergency Services
                  // Container(
                  //   // color: Colors.red,
                  //   child: MaterialButton(
                  //     color: Colors.red,
                  //     onPressed: () {
                  //       _origin = null;
                  //       _destination = null;
                  //       _currentLocation = null;
                  //       // Navigator.push(context, MaterialPageRoute(builder: (c)=>DriverPage(destinationPlace: searchDestinationController.text,)));
                  //       Navigator.pushReplacement(context,
                  //           MaterialPageRoute(builder: (_) => EmergencyServices()));
                  //
                  //     },
                  //     child: Text("Emergency"),
                  //   ),
                  // ),
                  SizedBox(width: 8,),
                  //Start
                  Container(
                    // color: Colors.red,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        print("Hi");
                        // _origin = null;
                        // _destination = null;
                        // _currentLocation = null;
                        // Navigator.push(context, MaterialPageRoute(builder: (c)=>DriverPage(destinationPlace: searchDestinationController.text,)));
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) => EmergencyServices()));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Tracking()));
                        // CommonStyles.snackBar(context, "Not functional yet");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Not functional Yet!!'))
                        );

                      },
                      child: Text("Start"),
                    ),
                  ),
                ],
              ),
            ],
        ),
      ),
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.red,
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>EmergencyServices()));
              },
              heroTag: 'sos',
              child: Icon(Icons.sos),
            ),
            const SizedBox(width: 200,),
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.black,
              onPressed: () => _googleMapController.animateCamera(
                  _info != null ?
                  CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                      :_setCurrentPositionAndMarker()
                // :CameraUpdate.newCameraPosition(
                // CameraPosition(
                //   target: LatLng(_currentPosition.latitude,_currentPosition.longitude),
                //   zoom: 14,
                // )),
              ),
              heroTag: 'loc',
              child: Icon(Icons.my_location),
            ),

          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}