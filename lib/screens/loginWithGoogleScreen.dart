import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal_maps/screens/login.dart';
import 'package:sal_maps/screens/mapScreen.dart';

import '../widgets/googleSignIn.dart';

class SignInGoogle extends StatefulWidget {
  const SignInGoogle({Key? key}) : super(key: key);

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.firebaseNavy,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(
                      'assets/icon/SAL_Maps_Final.png',
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'General User Login',
                    style: TextStyle(
                      // color: CustomColors.firebaseYellow,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: 24,)
                ],
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                  );
                },
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    // authenticate();
                    print("Login Tapped");
                    // authenticate();
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginPage()));
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
                          "Login for emergency Services",
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

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {

  bool _isSigningIn = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () async {
                  // authenticate();
                  print("Login google Tapped");
                  setState(() {
                    _isSigningIn = true;
                  });

                  // TODO: Add a method call to the Google Sign-In authentication
                  User? user =
                      await Authentication.signInWithGoogle(context: context);

                  setState(() {
                    _isSigningIn = false;
                  });
                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MapScreen()),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                      child: Text(
                    "Sign In With Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
                ),
              ),
            ),
    );
  }
}