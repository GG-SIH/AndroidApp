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
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8,),
                Container(
                  // width: MediaQuery.of(context).size.width*0.8,
                  // height: 60,
                  // decoration: const BoxDecoration(
                  //   color: Colors.grey,
                  //   borderRadius: BorderRadius.all(Radius.circular(20))
                  // ),
                  child: const Center(
                    child: Text(
                      'Which Service do you require?',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const Ambulance()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Ambulance'),
                        const Icon(Icons.local_hospital)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const FireService()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Fire Service'),
                        const Icon(Icons.fire_extinguisher)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  height: 60,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Both'),
                      Container(
                        child: Row(
                          children: [
                            const Icon(Icons.local_hospital),
                            const Icon(Icons.fire_extinguisher),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                Container(
                  child: GestureDetector(
                    child: Container(
                        child: const Text('Confirm')
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ambulance extends StatelessWidget {
  const Ambulance({Key? key}) : super(key: key);

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
              const Text('Hang Tight,\nEmergency Services on the way!!'),
              const SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.red
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8,),
                    const Text('Ambulance on the way'),
                    const SizedBox(height: 8,),
                    const Text('ETA: 14 min'),
                    const SizedBox(height: 8,),
                    const Text('Phone Number: +91 1234567890'),
                    const SizedBox(height: 8,),
                    const Text('Details: Ambulance No : KA 00 ML 1234'),
                    const SizedBox(height: 8,),
                  ],
                ),
              ),
            ],
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
              const Text('Hang Tight,\nEmergency Services on the way!!'),
              const SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.red
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8,),
                    const Text('Fire Truck on the way'),
                    const SizedBox(height: 8,),
                    const Text('ETA: 14 min'),
                    const SizedBox(height: 8,),
                    const Text('Phone Number: +91 1234567890'),
                    const SizedBox(height: 8,),
                    const Text('Details: Fire Truck No : KA 00 ML 1234'),
                    const SizedBox(height: 8,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

