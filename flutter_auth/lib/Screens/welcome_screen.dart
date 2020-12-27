
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/authenticate/login_screen.dart';
import 'package:flutter_auth/Screens/authenticate/signup_screen.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key, this.user}) : super(key: key);
  final User user;

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcomes.gif"),
            fit: BoxFit.cover,
          ),
        ),
      
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Positioned(child: Image.asset("assets/images/logo.png", width: size.width,),),
            SizedBox(height: 250.0),
            RoundedButton(
              text: "LOGIN",
              textColor: Colors.amber,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.teal,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Register();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      
    ),
    );
  }
}