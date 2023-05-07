import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/helper/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  String s="";
  TextEditingController controller = TextEditingController();
  SearchScreen({required String s,required TextEditingController c}) {
    this.s = s;
    this.controller = c;
  }
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = "122345";
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      onChange();
    });
  }
  void onChange() {
    if(_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(widget.controller.text);
  }

  void getSuggestion(String input) async {
    print("Inside getSuggestion");
    String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseUrl?input=$input&key=$apiKey&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data from autocomplete: "+data);
    if(response.statusCode==200) {
       if(mounted) {
         setState(() {
           _placeList = jsonDecode(response.body.toString())['predictions'];
         });
       }
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: 'Search places with name'
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placeList.length,
                  itemBuilder: (context,index) {
                return ListTile(
                  onTap: () {
                    widget.controller.text = _placeList[index]['description'];
                    Navigator.pop(context);
                  },
                  title: Text(_placeList[index]['description']),
                );
              }
              ),
            )
          ],
        ),
      ),
    );
  }
}
