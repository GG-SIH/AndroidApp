import 'package:flutter/material.dart';

class EmergencyServices extends StatelessWidget {

  bool ambulanceTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Service"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8,),
                Container(

                  child: const Center(
                    child: Text(
                      'Which Service do you require?',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32,),
                GestureDetector(
                  onTap: () async {

                    final ConfirmAction? action = await await _asyncConfirmDialog(
                        context,'Ambulance');
                    print("Confirm Action Ambulance $action");
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    height: 160,
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                        'assets/icon/ambulance.png'
                        ),
                        Text('Ambulance',style: TextStyle(fontSize: 24),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48,),
                GestureDetector(
                  onTap: () async {
                    final ConfirmAction? action = await await _asyncConfirmDialog(
                        context,'Fire Brigade');
                    print("Confirm Action Fire $action");
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    height: 160,
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/icon/fire.png'
                        ),
                        Text('Fire Brigade',style: TextStyle(fontSize: 24),),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
enum ConfirmAction { Cancel, Accept}
  Future<Future<ConfirmAction?>> _asyncConfirmDialog(BuildContext context,String service) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected ${service}'),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'The Nearest $service will reach to you in :',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                Text(
                  '14 min',
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
              child: Text('Cancel',style: TextStyle(),),
            ),
            MaterialButton(
              color: Colors.green,
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Accept);
                if(service=="Fire Brigade") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FireService()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Ambulance()));
                }
              },
            )
          ],
        );
      },
    );
  }


class Ambulance extends StatelessWidget {
  const Ambulance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4,),
                Text('Hang Tight,\nEmergency Services on the way!!',
                style: TextStyle(
                  fontSize: 22
                ),),
                SizedBox(height: 8,),
                Container(
                    child: Image.asset('assets/images/eta_screen.png'),
                  padding: EdgeInsets.all(12),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  // padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.green
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 6,),
                      Text('Ambulance on the way',style: TextStyle(
                          fontSize: 18
                      ),),
                      SizedBox(height: 6,),
                      Text('ETA: 14 min',style: TextStyle(
                          fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            'Phone Number: +91 1234567890',
                            style: TextStyle(
                              fontSize: 18
                            ),
                          ),
                          SizedBox(width: 4,),
                          Icon(Icons.call)
                        ],
                      ),
                      SizedBox(height: 6,),
                      Text('Details: Ambulance No : KA 00 ML 1234',style: TextStyle(
                          fontSize: 18
                      ),),
                      SizedBox(height: 6,),                        // onPresse
                    ],
                  ),
                ),
                MaterialButton(
                  color: Colors.red,
                  onPressed: (){
                    Navigator.pop(context);
                },
                child: Text('Cancel'),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FireService extends StatelessWidget {
  const FireService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hang Tight,\nEmergency Services on the way!!',
                style: TextStyle(
                    fontSize: 24
                ),),
              SizedBox(height: 16,),
              Container(
                child: Image.asset('assets/images/eta_screen.png'),
                padding: EdgeInsets.all(16),
              ),
              Container(
                margin: EdgeInsets.all(16),
                // padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.green
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 8,),
                    Text('Fire Brigade on the way',style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(height: 8,),
                    Text('ETA: 14 min',style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(height: 8,),
                    Text('Phone Number: +91 1234567890',style: TextStyle(
                        fontSize: 18
                    ),),
                    SizedBox(height: 8,),
                    Text('Details: Fire Brigade No : KA 00 ML 1234',style: TextStyle(
                        fontSize: 18
                    ),),                       // onPresse
                  ],
                ),
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Cancel'),)
            ],
          ),
        ),
      ),
    );
  }
}

