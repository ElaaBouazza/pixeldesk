import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/screens/welcome_screen.dart';
import 'package:flutter_auth/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Usern>(context);
    
    // return either the Home or welcomescreen widget
    if (user == null){
      return WelcomeScreen();
    } else {
      return Home();
    }
    
  }
}