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
    var request = http.Request('GET', Uri.parse('https://salmaps-app.azurewebsites.net/api/SALApp/confirmUser'));
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
      print("response in fun checkNow() : " + response.body);
      bool x = response.body.toString()=="true";
      return x;
      // return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future<bool> confirmService(String service) async {
    print("In confirm Service function");
    // to be always run from ambulance side
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('https://salmaps-app.azurewebsites.net/api/SALApp/confirmAmbulance'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 200) {
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      // print(result["message"]);
      var userConfirmation = result["userConfirmation"];
      // double latitude = result["currentLocation"]["lat"].toDouble();
      // double longitude = result["currentLocation"]["lng"].toDouble();
      print("userConfirmation ${userConfirmation}");
      return userConfirmation;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future<Map<String, dynamic>> sendServiceLocation() async {

    print("In send Service locaiton function");
    Position pos = await GeoLocatorServices.determineCurrentPosition();
    double cLat = pos.latitude;
    double cLng = pos.longitude;
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('https://salmaps-app.azurewebsites.net/api/SALApp/confirmUser'));
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
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      double eta = result["eta"];
      print("eta ${eta}");
      return result;
    } else {
      print(response.reasonPhrase);
      return {"message":response.reasonPhrase};
    }
  }
}