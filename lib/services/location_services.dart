import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationServices {
  static String _apiKey = "AIzaSyBcQSmBY1QhFLMcfDHsIFp5YEgdj6I_Ge8";

  Future<String> getPlaceId(String place) async {
    final String _baseURL = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$place&inputtype=textquery&key=$_apiKey";

    try {
      var response = await http.get(Uri.parse(_baseURL));
      var json = convert.jsonDecode(response.body);
      var placeId = json['candidates'][0]['place_id'] as String;
      print("LocationService:");
      print(json)
;      return placeId;
    } catch (e) {
      print(e.toString());
      return "Error";
    }
  }

  Future<Map<String ,dynamic>> getPlace(String place) async {

    // TO get the location from place use place['geometry']['location']['lat']

    final placeId = await getPlaceId(place);
    final String _url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_apiKey";

    try {
      var response = await http.get(Uri.parse(_url));
      var json = convert.jsonDecode(response.body);
      var result = json['result'] as Map<String , dynamic>;
      print("Result in getPlace method : $result");
      print("Json in getPlace methode: $json");
      return result;
    } catch (e) {
      print(e.toString());
      return {'e':'Error'};
    }
  }
}