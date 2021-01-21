import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_auth/Screens/home/functions/timer.dart';

class TimersList extends StatefulWidget {
  @override
  _TimersListState createState() => _TimersListState();
}

/*class _TimersListState extends State<TimersList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}*/

class _TimersListState extends State<TimersList> {
  Query _ref;
  Query db;
  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child('Timers');
  }

  void removeNode(String name) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.pink[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: new Text(
              "Remove this Timer",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this Timer ?',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(
                  "Close",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  FirebaseDatabase.instance
                      .reference()
                      .child('Timers')
                      .orderByChild('timespent')
                      .equalTo(name)
                      .once()
                      .then((DataSnapshot snapshot) {
                    Map<dynamic, dynamic> children = snapshot.value;
                    children.forEach((key, value) {
                      FirebaseDatabase.instance
                          .reference()
                          .child('Timers')
                          .child(key)
                          .remove();
                    });
                  });
                },
              ),
            ],
          );
        });
  }

  Widget _buildTimerItem({Map timer}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.pink[50],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /*const*/ ListTile(
              leading: Icon(
                Icons.play_arrow_rounded,
                color: Colors.black,
                size: 40,
              ),
              title: Text(
                timer['timespent'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, 
                  fontFamily: 'Pixel',//Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              /*subtitle: Text(
                timer['date'],
                style: TextStyle(
                  fontSize: 16,
                  //color: Theme.of(context).accentColor,
                  //fontWeight: FontWeight.w600,
                ),
              ),*/
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    timer['date'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontFamily: 'Pixel'
                      //color: Theme.of(context).accentColor,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),

                  //Text('BTN1'),
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey[600],
                  ), //Text('BTN2'),
                  //Text('BTN2'),
                  onPressed: () {
                    removeNode(timer['timespent']);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        // The containers in the background
        new Scaffold(
          body: Container(
            //height: double.infinity,
            child: FirebaseAnimatedList(
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .25,
                  right: 10.0,
                  left: 5.0),
              query: _ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map timer = snapshot.value;
                return _buildTimerItem(timer: timer);
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return TimerHome();
              }));
            },
            elevation: 5.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        new Column(
          children: <Widget>[
            /*new Container(
              height: MediaQuery.of(context).size.height * .15,
              color: Colors.pink[100],
            ),*/

            Positioned(
              top: 0,
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .15,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .25,
              left: 20,
              right: 20,
              child: Card(
                elevation: 8,
                color: Colors.pink[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.height * .90,
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 60,
                          ),
                          //Text("SCAN QR")
                        ],
                      ),
                      Container(
                        height: 100,
                        width: 2,
                        color: Colors.white,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          /*Icon(
                            Icons.bluetooth,
                            color: Colors.white,
                            size: 45,
                          ),*/
                          Text(
                            sumTimers(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
    /*return Scaffold(
                                appBar: AppBar(
                                  title: Text("Desk Timers"),
                                ),
                                body: Container(
                                  //height: double.infinity,
                                  child: FirebaseAnimatedList(
                                    query: _ref,
                                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                                        Animation<double> animation, int index) {
                                      Map timer = snapshot.value;
                                      return _buildTimerItem(timer: timer);
                                    },
                                  ),
                                ),
                                floatingActionButton: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                                      return TimerHome();
                                    }));
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              );*/
  }

  String sumTimers() {
    String sumstring;
    int sumseconds = 0;
    List<String> hms;
    List<String> list;
    List<int> listint;

    //print(timer['timespent']);
    /*FirebaseDatabase.instance
        .reference()
        .child('Timers')
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> children = snapshot.value;
      children.forEach((key, value) {
        list.add(children['timespent']);
        //print(children['timespent']);
        //FirebaseDatabase.instance.reference().child('Timers').child(key);
      });
    });*/
    FirebaseDatabase.instance
        .reference()
        .child("Timers")
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        list.add(values["timespent"]);
        //FirebaseDatabase.instance.reference().child('Timers').child(key);
      });
    });

    /*int c = 0;
    for (var x in list) {
      hms = x.split(":");

      listint[c] = int.parse(hms[0]) * 60 * 60 +
          int.parse(hms[1]) * 60 +
          int.parse(hms[2]);
      c = c + 1;
      sumseconds = sumseconds + listint[c];
    }*/
    sumstring = secondstoString(sumseconds);

    return sumstring;
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

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        child: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
