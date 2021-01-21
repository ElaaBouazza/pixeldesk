import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_auth/Screens/home/functions/timer.dart';

public class TimerE {
  DateTime date;
  String timespent;
  String title;

  TimerE(){}
  public TimerE(DateTime date, String timespent, String title){
    this.date=date;
    this.timespent=timespent;
    this.title=title;
  }
  
}