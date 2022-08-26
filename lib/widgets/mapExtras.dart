import 'package:flutter/material.dart';

class DrivingInfo extends StatelessWidget {
  const DrivingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        color: Colors.white,
        height: height/3,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[

              SizedBox(height: 4,),
              Container(
                child: Row(
                  children: [
                    Text(
                      '2 min (270 m)',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    Icon(Icons.local_parking,size: 18,),
                    Text(
                      'Medium',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    )
                  ],
                ),
              ),// Top Info Time and distance
              SizedBox(height: 10,),
              Text(
                'Fastest route now due to traffic conditions',
                style: TextStyle(
                    fontSize: 17
                ),
              ),
              SizedBox(height: 24,),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("Start tapped");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Functionality Added yet")));
                        // CommonStyles.snackBar(context, "No Functionality Added yet");
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.navigation,size: 22,),
                            SizedBox(width: 2,),
                            Text(
                                'Start',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    GestureDetector(
                      onTap: () {
                        print("Emergency tapped");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Its complete but was not in a mood to integrate it now")));
                        // CommonStyles.snackBar(context, "Its complete but was not in a mood to integrate it now");
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emergency,size: 22,),
                            SizedBox(width: 2,),
                            Text(
                              'Emergency',
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                    ),
                  ],
                ),
              )// Bottom buttons start , emergency
            ],
          ),
        ),
      ),
    );
  }
}
