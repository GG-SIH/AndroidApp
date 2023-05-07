import 'dart:developer';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sal_maps/helper/constants.dart';

import 'directions.dart';

class DirectionRepository {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";

  static const String _apiKey = apiKey;

  final Dio _dio;
  DirectionRepository({Dio? dio}) : _dio = dio??Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin' : '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': _apiKey
      },
    );

    if(response.statusCode==200) {
      print("Latitudes: ${origin.latitude} Longitude: ${origin.longitude}");
      print("Latitudes: ${destination.latitude} Longitude: ${destination.longitude}");
      log("Response DirectionDirectory:"+response.data.toString());
      // var x = response.data.routes[0].overview_polyline;
      // print("Response x1:"+x);
      return Directions.fromMap(response.data);
    } else {
      print("Response Status Code: ${response.statusCode}");
      return null;
    }
  }

  static Future<Map<String,dynamic>> getServerResponse(String polyline) async {
    polyline = polyline.replaceAll("\\", "");
    var headers = {
      'Content-Type': 'application/json'
    };
    print("Polyline sending="+polyline+":till here");
    var request = http.Request('POST', Uri.parse(
        'https://sal-maps-restful-api.onrender.com/api/routes/mainController/'));
    request.body = json.encode({
      "polyline": polyline
      // "polyline": "{|lnAgpoxMV_Na@y@YYuDCk@@a@AQO_NHsF@sBG}@O_AQwASiAWaEg@_@TuE`G}@z@a@f@_@l@y@fCq@dBIHa@Ng@H[`@]r@c@d@sAbA_@XUNMpBKz@M`AWhCc@jEc@dFUtB]jDc@xDuAlK\\Xg@JAPi@j@q@n@{BvBiBnBaBlBaCxC}CtDcBpB?DGnBCj@a@~JbDTLsBHsAFgApAHJqBAEACHE`@?P?@g@@QDGLCdCL^BFB@ROzDGJQBo@E"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 200) {
      print("response in fun:"+response.body);
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print(result.toString());
      Server.mp = {
        "dynamic_radius" : result["dynamic_radius"]??"1000.0",
        'immediate_waypoints' : result["immediate_waypoints"]??null,
        "max_radius" : result["max_radius"]??"1000.0",
      };
      print("done dana done");
      // print(result["result"]);
      // return result["result"];
      return result;
    } else {
      print(response.reasonPhrase);
      return {};
    }
    Map<String , dynamic> mp={};
    request.send().then((result) async {
      http.Response.fromStream(result)
          .then((response) {
        if (response.statusCode == 200) {
          print('response.body ' + response.body);
          final result = jsonDecode(response.body) as Map<String, dynamic>;
          var x = result["dynamic_radius"];
          print("dynamic radius="+x.toString());
          Server.mp = {
            "dynamic_radius" : result["dynamic_radius"]??"0.0",
            'immediate_waypoints' : result["immediate_waypoints"]??null,
          };
          return Server.mp;
        }
        // return response.body;
      });
    }).catchError((err) {
      print(err.toString());
      return null;
    }).whenComplete(() {
      return mp;
    });
    // return null;
    return mp;
  }
  static Future<bool> checkNow() async {
    var request = http.Request('GET', Uri.parse('https://flutter-server.azurewebsites.net/requestAmbulance'));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 200) {
      print("response in fun checkNow() : " + response.body);
      bool x = response.body.toString()=="true";
      return x;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
  static Future<Map<String,dynamic>> userWithinRadius(double cLat,double cLng,int i) async {

    print("in user within radius function");

    var headers = {
      'Content-Type': 'application/json'
    };
    double iLat,iLng;
    if(Server.mp.isNotEmpty) {
      iLat = Server.mp["immediate_waypoints"][i]["lat"];
      iLng = Server.mp["immediate_waypoints"][i]["lng"];
      print(iLat);
      print(iLng);
    } else {
      throw Exception("Server mp empty");
    }
    var request = http.Request('POST', Uri.parse(
        'https://sal-maps-restful-api.onrender.com/api/routes/userLocatedWithinRadius/'
        // 'https://salmaps-app.azurewebsites.net/api/SALApp/userLocatedWithinRadius'
    ));
    request.body = json.encode({
      "currentLocation": {
        "lat": cLat,
        "lng": cLng
      },
      "iwaypoints": {
        "lat": iLat,
        "lng": iLng
      },
      "radius": Server.mp["dynamic_radius"],
      "maxRadius": Server.mp["max_radius"]
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 200) {
      print("response in fun:"+response.body);
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      print(result.toString());
      print("Green: "+result["green"].toString()+"Yellow: "+result["yellow"].toString());
      Map<String,dynamic> nmp = {
        "green":result["green"],
        "yellow":result["yellow"],
      };
      return nmp;
    } else {
      print(response.reasonPhrase);
      return {};
    }

    // var headers = {
    //   'Content-Type': 'application/json'
    // };
    // var request = http.Request('GET', Uri.parse('https://salmaps-app.azurewebsites.net/api/SALApp/userLocatedWithinRadius'));
    // request.body = json.encode({
    //   "currentLocation": {
    //     "lat": 13.01454,
    //     "lng": 77.57093
    //   },
    //   "iwaypoints": {
    //     "lat": 13.02777,
    //     "lng": 77.57458
    //   },
    //   "radius": 12.8368856
    // });
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   print("response in func:"+await response.stream.bytesToString());
    //   return response.stream.
    // }
    // else {
    // print(response.reasonPhrase);
    // }
    // return false;
  }
}

// cLat = 13.01454
// cLng = 77.57093