import 'dart:developer';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart'as http;

import '../services/getCurrentLocation.dart';

class RequestService {
// to be called in emergencyServices.dart line 150
  static Future<bool> requestService(String service) async {

    print("In request Service function");
    Position pos = await GeoLocatorServices.determineCurrentPosition();
    double cLat = pos.latitude;
    double cLng = pos.longitude;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('https://salmaps-server.azurewebsites.net/api/SALApp/confirmUser'));
    request.body = json.encode({
      "currentLocation": {
        "lat": cLat,
        "lng": cLng
      },
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 200) {
      // response format is
      /*
      {
    "message": "userLocatedWithinRadius is called123",
    "userConfirmation":true
}
      *
      * */

      print("response in fun checkNow() : " + response.body);
      // bool x = response.body.toString()=="true";
      // return x;
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<bool> confirmService(String service) async {
    print("In confirm Service function");
    // to be always run from ambulance side
    Position pos = await GeoLocatorServices.determineCurrentPosition();
    double cLat = pos.latitude;
    double cLng = pos.longitude;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('https://salmaps-server.azurewebsites.net/api/SALApp/confirmAmbulance'));
    request.body = json.encode({
      "currentLocation": {
        "lat": cLat,
        "lng": cLng
      },
    });
    request.headers.addAll(headers);


    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 200) {
      // response format is
      /*
      {
    "message": "notify2 for ambulance is called123",
    "userConfirmation": true,
    "currentLocation": {
        "lat": 13.03001,
        "lng": 77.56595
    }
} using this current location to set the directions for driver.
      *
      * */

      print("response in fun checkNow() : " + response.body);
      bool x = response.body.toString()=="true";
      return x;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}