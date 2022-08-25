
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directionsDirectory.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration
  });

  static Directions? fromMap(Map<String, dynamic> map) {
    if((map['routes'] as List).isEmpty) return null;

    final data = Map<String,dynamic>.from(map['routes'][0]);

    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    // var y = data['overview_polyline'];
    // print("Res y: "+y+" ends");
    var x = data['overview_polyline']['points'];
    print("Response x:"+x+" ended here");

    Server.callServer(x);
    List<PointLatLng> results = getPolylinePoints(x);

    print(results);

    final bounds = LatLngBounds(
        southwest: LatLng(southwest['lat'],southwest['lng']),
        northeast: LatLng(northeast['lat'],northeast['lng'])
    );

    String distance = '';
    String duration = '';

    if((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(bounds: bounds,
        polylinePoints: PolylinePoints().decodePolyline(
          data['overview_polyline']['points']
        ),
        totalDistance: distance,
        totalDuration: duration
    );
  }
  static List<PointLatLng> getPolylinePoints(String overview_polyline) {
    PolylinePoints polylinePoints = PolylinePoints();

    List<PointLatLng> result = polylinePoints.decodePolyline(overview_polyline);
    print("Points :$result");
    return result;
  }

}

class Server {
  static Map<String,dynamic> mp={
    "dynamic_radius": 0.026883945865700153,
    "immediate_waypoints": [
      {
        "lat": 13.03046,
        "lng": 77.56496
      },
      {
        "lat": 13.03022,
        "lng": 77.56493
      }
    ]
  };
  static Future<void> callServer(String polyline) async {
    mp = await DirectionRepository.getServerResponse(polyline);
    print("in server call server");
    print(mp["dynamic_radius"]);
    // mp = await DirectionRepository.getServerResponse("{|lnAgpoxMV_Na@y@YYuDCk@@a@AQO_NHsF@sBG}@O_AQwASiAWaEg@_@TuE`G}@z@a@f@_@l@y@fCq@dBIHa@Ng@H[`@]r@c@d@sAbA_@XUNMpBKz@M`AWhCc@jEc@dFUtB]jDc@xDuAlK\\Xg@JAPi@j@q@n@{BvBiBnBaBlBaCxC}CtDcBpB?DGnBCj@a@~JbDTLsBHsAFgApAHJqBAEACHE`@?P?@g@@QDGLCdCL^BFB@ROzDGJQBo@E");
  }
}