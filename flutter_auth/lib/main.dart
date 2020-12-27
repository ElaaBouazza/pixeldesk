import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/wrapper.dart';
import 'package:flutter_auth/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/services/auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usern>.value(     
      value: AuthService().user,    
      child: MaterialApp( 
       debugShowCheckedModeBanner: false,
       title: 'Flutter Auth',
       theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
       home: Wrapper(),
    ),
    );
  }
}