import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/screens/home/settings_form.dart';
import 'package:flutter_auth/services/auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  
  


  @override
    State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";

  get backgroundColor => null;

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
   final AuthService _auth = AuthService();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgoundColor,
      appBar: AppBar(
        backgroundColor:backgoundColor,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: kPrimaryLightColor,),
            label: Text('logout'), textColor: kPrimaryLightColor,
            onPressed: () async {await _auth.signOut();},
          )    
        ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey, 
          color: Colors.white,
          backgroundColor: backgroundColor,
          height: 50,
          items: <Widget>[
            Icon(Icons.home_rounded, size: 20, color: Colors.black),
            Icon(Icons.home_rounded, size: 20, color: Colors.black),
            Icon(Icons.home_rounded, size: 20, color: Colors.black),
            Icon(Icons.home_rounded, size: 20, color: Colors.black),
          ],
          animationDuration: Duration(milliseconds: 200),
          animationCurve: Curves.bounceInOut,
          onTap: (index){setState(() {
            _page=index;
          });}
        ),

        
    );
  }
}