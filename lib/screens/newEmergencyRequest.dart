import 'package:flutter/material.dart';
import 'package:sal_maps/screens/tracking.dart';
class newEmergencyRequest extends StatelessWidget {
  newEmergencyRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Requests'),),
      body: SafeArea(
        child: Container(
          child: showAlertDialog(context),
        ),
      )
    );


  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Confirm"),
      onPressed:  () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> Tracking()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Emergency Request"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
