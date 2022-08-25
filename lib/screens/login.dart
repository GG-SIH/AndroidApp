import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_maps/screens/emergencyServices.dart';
import 'package:sal_maps/screens/mapScreen.dart';

import '../widgets/common_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users.add(
        {
          'name':"ABC",
          "age":"25"
        }
    ).then((value) => print("User Added"))
        .catchError((error)=>print("Error "));
  }

  void authenticate() {
    String phoneNumber = "+91"+phoneNumberController.text.toString();
    print(phoneNumber);
    if(_formKey.currentState!.validate()) {
      print("validating data");
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (c) => OTPScreen(phoneNumber: phoneNumber)));
    } else {
      print("Error Occurred");
      CommonStyles.snackBar(context, "Error Occurred!");
    }
  }

  @override
  void dispose() {
    print("Disposing");
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(
                  'assets/icon/sihlogo.png',
                ),
                height: 100,
              ),
              // Text(
              //     'SAL Maps',
              //     style: GoogleFonts.bebasNeue(
              //         fontSize: 48
              //     )
              // ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 32,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) {
                          if(value==null || value.isEmpty) {
                            return 'It Cannot be Empty';
                          } else if(value.length!=10) {
                            return 'It should be 10 characters';
                          } else if(value.contains(' ')) {
                            return 'No Space Allowed';
                          } else if(value.contains("-")) {
                            return 'No \'-\' Allowed';
                          } else if(value.contains(".")) {
                            return 'No \'.\' Allowed';
                          } else if(value.contains(",")) {
                            return 'No \',\' Allowed';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Enter Phone",
                            hintStyle: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400
                            ),
                            // icon: Icon(Icons.phone),
                            prefixIcon: Column(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.call,size: 18,),
                                    SizedBox(width: 4,),
                                    Text(
                                      "+91 :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                        keyboardType: TextInputType.number,
                        // maxLength: 10,
                        controller: phoneNumberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    print("Login Tapped");
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const MapScreen()));
                    // authenticate();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
