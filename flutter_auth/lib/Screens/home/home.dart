import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/Screens/home/functions/dashboard.dart';
import 'package:flutter_auth/Screens/home/functions/settings.dart';
import 'package:flutter_auth/Screens/home/functions/statistics.dart';
import 'package:flutter_auth/Screens/home/functions/timetable.dart';
import 'package:flutter_auth/services/auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

class Home extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Dashboard(),
    Timetable(),
    Statistics(),
    Settings(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard(); 
  @override
  void initState(){
        
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    super.initState();
  }
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
      //Init Floating Action Bubble 
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title:"Timer",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.settings,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title:"Profile",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.people,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),


        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: _animationController.isCompleted
            ? _animationController.reverse
            : _animationController.forward,
        
        // Floating Action button Icon color
        iconColor: Colors.blue,

        // Flaoting Action button Icon 
        icon: AnimatedIcons.add_event,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ), 
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  updateTabSelection(0, "Home");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.home_rounded,
                  //darken the icon if it is selected or else give it a different color
                  color: selectedIndex == 0
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(1, "TimeTable");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.calendar_today_rounded,
                  color: selectedIndex == 1
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              SizedBox(
                width: 50.0,
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(2, "To Do's");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.check_circle_outline,
                  color: selectedIndex == 2
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(3, "Settings");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.settings,
                  color: selectedIndex == 3
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar
        color: Colors.white,
      ),
      
    );
  }
}