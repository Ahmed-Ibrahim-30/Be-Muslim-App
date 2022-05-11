import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Calculate_AM_PM.dart';
import 'Functions.dart';
var location="No Connection yet!!";
int Pray_index=0,sound_duration=0;
Color background_color=Colors.black.withOpacity(0.5),
    remain_color=Colors.teal[400];
String backgroundimage='Images/img32.jpg';
String background_small='Images/img6.jpg';
double height_small=20;
Color Appbar_background=Colors.white54;

int default_layout=0;
var diff=0, second = DateFormat('ss').format(DateTime.now()),
time_now = DateFormat('HH:mm:ss').format(DateTime.now());
List<int>min=[0,0,0];
const kPrimaryColorOne = Color.fromARGB(255, 31, 31, 31);
const kPrimaryColorTwo = Color.fromARGB(255, 48, 85, 92);

String Pray=difference(time_now)[0]==0?"صلاه الفجر":difference(time_now)[0]==1?"الشروق":difference(time_now)[0]==2?"صلاه الظهر":
difference(time_now)[0]==3?"صلاه العصر":difference(time_now)[0]==4?"صلاه المغرب":"صلاه العشاء";


var colors=[Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70];
Color color_selected=Colors.yellowAccent;
int color_selected_int;