import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/functions/timer.dart';
import 'package:flutter_auth/Screens/home/functions/timerslist.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/home/functions/dashboard.dart';
import 'package:flutter_auth/Screens/home/functions/settings.dart';
import 'package:flutter_auth/Screens/home/functions/statistics.dart';
import 'package:flutter_auth/Screens/home/functions/timetable.dart';
import 'package:flutter_auth/services/auth.dart';

import 'calendar.dart';
import 'functions/category.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  int _selectedIndex = 0;
  String text = "";
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Categories(),
    Dashboard(),
    Timetable(),
    Statistics(),
    Settings(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }



  void updateTabSelection(int index, String buttonText) {
    setState(() {
      _selectedIndex = index;
      text = buttonText;
    });
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      new Scaffold(
        backgroundColor: Colors.white, //backgroundColor,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
        appBar: AppBar(
          backgroundColor: retroCo, //backgroundColor,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: kPrimaryLightColor,
              ),
              label: Text('LOGOUT'),
              textColor: kPrimaryLightColor,
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),


        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 60,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            MaterialButton(minWidth:40, onPressed: (){ setState((){currentScreen = TimersList(); currentTab = 0;});
            },
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.dashboard_rounded, color: currentTab==0 ? retroCo: kPrimaryLightColor,
              ),
              Text('Dashboard', style: TextStyle(color:currentTab==0 ? retroCo: kPrimaryLightColor, fontFamily: 'Pixel',
              ),
              ),
            ],
            ),
            ),
            MaterialButton(minWidth: 40, onPressed: () {setState(() {currentScreen = Calendar(); currentTab = 1;});},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today_rounded, color: currentTab == 1 ? retroCo: kPrimaryLightColor,
                        ),
                  Text(
                    'TimeTable',
                    style: TextStyle(color: currentTab == 1 ? retroCo: kPrimaryLightColor, fontFamily: 'Pixel',
                      ),
                    ),
                ],
                ),
              ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            MaterialButton(minWidth: 40, onPressed: () {
              setState(() {currentScreen = Categories(); // if user taps on this dashboard tab will be active
                currentTab = 2;
                      });
                    },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.dvr_rounded,
                  color: currentTab == 2 ? retroCo: kPrimaryLightColor,
                        ),
                  Text(
                          'Tasks',
                          style: TextStyle(
                            color: currentTab == 2 ? retroCo: kPrimaryLightColor, fontFamily: 'Pixel',
                          ),
                        ),
                      ],
                    ),
                  ),
              MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Statistics(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.insert_chart,
                    color: currentTab == 3 ? retroCo: kPrimaryLightColor,
                        ),
                  Text(
                          'Stats',
                          style: TextStyle(
                            color: currentTab == 3 ? retroCo: kPrimaryLightColor, fontFamily: 'Pixel',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          
          //to add a space between the FAB and BottomAppBar

          //color of the BottomAppBar
      
                ]  ),
               ] ),
      

      ),)
    )]);
  }
}
