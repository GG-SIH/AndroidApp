import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import 'emergencyServices.dart';
class LoadingSkeleton extends StatelessWidget {
  String source = "";
  LoadingSkeleton({required String s}) {
    this.source = s;


  }

// Go to Page2 after 5s.

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () {
      if(source=="Ambulance and Fire Brigade"){
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AmbulanceAndFireService()));
      }
      else if(source=="Fire Brigade") {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const FireService()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const Ambulance()));
      }
      // Navigator.pop(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirming your service')
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 60.0,),
            const Text(
                'Waiting for service to accept your request',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
            ),
          SizedBox(height: 60.0,),
          Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          period: Duration(milliseconds: 1000),
          child: box(),
          )
          ],
        ),
      ),
    );
  }


  Widget box(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  width:  200,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}