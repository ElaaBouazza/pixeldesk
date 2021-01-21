import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:flutter/src/material/colors.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

/*void main() {
  runApp(MyApp());
}*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Manager',
      //color: Colors.black,

      theme: ThemeData(
        primarySwatch: Colors.pink[900],
      ),
      home: TimerHome(title: 'Your Desk Timer'),
      //Scaffold(),
    );
  }
}

class TimerHome extends StatefulWidget {
  TimerHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TimerHomeState createState() => _TimerHomeState();
}

class _TimerHomeState extends State<TimerHome> with TickerProviderStateMixin {
  DatabaseReference _ref;

  String formattedDate;
  String formattedDateStopwatch;
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  bool reseted = true;
  int timeforTimer = 0;
  int firsttimeforTimer = 0;
  String timetodisplay = "";

  bool checktimer = true;
  //var time = timer();

  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child('Timers');
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
      reseted = true;
    });

    timeforTimer = hour * 60 * 60 + min * 60 + sec;
    firsttimeforTimer = timeforTimer;
    //debugPrint(timeforTimer.toString());
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      setState(() {
        if (timeforTimer < 1 || checktimer == false) {
          t.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TimerHome(),
              ));
        } else if (timeforTimer < 60) {
          timetodisplay = timeforTimer.toString();

          timeforTimer = timeforTimer - 1;
          //timeforTimer = timeforTimer + 1;
        } else if (timeforTimer < 3600) {
          int m = timeforTimer ~/ 60;
          int s = timeforTimer - (60 * m);
          timetodisplay = m.toString() + ":" + s.toString();

          timeforTimer = timeforTimer - 1;
          //timeforTimer = timeforTimer + 1;
        } else {
          int h = timeforTimer ~/ 3600;
          int t = timeforTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);

          timetodisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();

          timeforTimer = timeforTimer - 1;
          //timeforTimer = timeforTimer + 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
    });
    saveTimeSpent(timetodisplay);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TimerHome(),
        ));
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "SET A SESSION" + "\n",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.pink[800],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            "HH",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                          initialValue: hour,
                          minValue: 0,
                          maxValue: 23,
                          listViewWidth: 80.0,
                          onChanged: (val) {
                            setState(() {
                              hour = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            "MM",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                          initialValue: min,
                          minValue: 0,
                          maxValue: 59,
                          listViewWidth: 80.0,
                          onChanged: (val) {
                            setState(() {
                              min = val;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            "SS",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        NumberPicker.integer(
                          initialValue: sec,
                          minValue: 0,
                          maxValue: 59,
                          listViewWidth: 80.0,
                          onChanged: (val) {
                            setState(() {
                              sec = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  timetodisplay,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: started ? start : null,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        color: Colors.green,
                        child: Text(
                          "START",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      RaisedButton(
                        onPressed: stopped ? null : stop,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        color: Colors.red,
                        child: Text(
                          "STOP",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //********************************************************
  //******************************************************* */
  //the stopwatch code
  //********************************************** */
  //*********************************************** */

  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void starttimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startstopwatch() {
    setState(() {
      stopispressed = false;
      startispressed = false;
    });

    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      stopispressed = true;
      resetispressed = false;
      startispressed = true;
    });
    swatch.stop();
  }

  void restestopwatch() {
    setState(() {
      startispressed = true;
      resetispressed = true;
    });
    saveTimer(stoptimetodisplay);
    swatch.reset();
    stoptimetodisplay = "00:00:00";
  }

  Widget stopwatch() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "START A SESSION",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  //fontFamily: 'MyFont',
                  color: Colors.pink[800],
                ),
              ),
            ),
          ),
          //Image(image: AssetImage('assets/images/space.png')),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stoptimetodisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                  //fontFamily: 'Pixel',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: stopispressed ? null : stopstopwatch,
                        color: Colors.redAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          "STOP",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              //fontFamily: 'Pixel',
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      RaisedButton(
                        onPressed: resetispressed ? null : restestopwatch,
                        color: Colors.cyan,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          "RESET",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              //fontFamily: 'Pixel',
                              color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: startispressed ? startstopwatch : null,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      "START",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          //fontFamily: 'Pixel',
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      //backgroundImage: AssetImage('assets/images/space.png'),
      //nzid feehom for background image
      //body: Container(
      //  constraints: BoxConstraints.expand(),
      //  decoration: BoxDecoration(
      //    image: DecorationImage(
      //        image: AssetImage("assets/images/space.png"), fit: BoxFit.cover),
      //  ),
      //),

      appBar: AppBar(
        title: Text(
          "Desk Timer",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        //centerTitle: true,
        bottom: TabBar(
          tabs: <Widget>[
            Tab(
              //child: Image.asset('assets/images/timer.png'),
              text: 'Timer',
              icon: Icon(
                Icons.timer,
              ),
            ),
            Tab(
              text: 'StopWatch',
              icon: Icon(
                Icons.access_time,
              ),
            ),

            //Text(
            //  "Timer",
            //),
            //Text(
            //  "StopWatch",
            //),
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          //labelStyle: TextStyle(
          //  fontSize: 18.0,
          //  fontWeight: FontWeight.w600,
          //),
          unselectedLabelColor: Colors.grey[700],
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          stopwatch(),
        ],
        controller: tb,
      ),
    );
  }

  void saveTimer(String timedata) async {
    DateTime now = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    Map<String, String> timer = {
      'timespent': timedata,
      'date': formattedDate,
    };
    _ref.push().set(timer);
    /*.then((value) {
          Navigator.pop(context);
        });*/
  }

  void saveTimeSpent(String timetodisplay) {
    DateTime now = DateTime.now();
    formattedDateStopwatch = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    int timeattent;
    int timespent = 0;
    List hms;
    hms = timetodisplay.split(":");

    timeattent = int.parse(hms[0]) * 60 * 60 +
        int.parse(hms[1]) * 60 +
        int.parse(hms[2]);
    timespent = firsttimeforTimer - timeattent;

    String timetosave;
    timetosave = secondstoString(timespent);

    Map<String, String> stopwatchtimer = {
      'timespent': timetosave,
      'date': formattedDateStopwatch,
    };
    _ref.push().set(stopwatchtimer);
  }

  String secondstoString(int tseconds) {
    String timoo;
    if (tseconds < 60) {
      timoo = "00:00:" + tseconds.toString();
      tseconds = tseconds - 1;
    } else if (tseconds < 3600) {
      int m = tseconds ~/ 60;
      int s = tseconds - (60 * m);
      timoo = "00:" + m.toString() + ":" + s.toString();
      tseconds = tseconds - 1;
    } else {
      int h = tseconds ~/ 3600;
      int t = tseconds - (3600 * h);
      int m = t ~/ 60;
      int s = t - (60 * m);
      timoo = h.toString() + ":" + m.toString() + ":" + s.toString();
      tseconds = tseconds - 1;
    }

    return timoo;
  }
}
