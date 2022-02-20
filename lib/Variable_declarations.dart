import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Calculate_AM_PM.dart';
import 'Functions.dart';

int Pray_index=0,sound_duration=0;
Color background_color=Colors.black.withOpacity(0.1),
    remain_color=Is_AM_PM?Colors.teal[200]:Colors.lightGreen[900];
String backgroundimage=Is_AM_PM?'Images/img7.jpg':min[0]==2?'Images/img25.jpg':'Images/img29.jpg';
String background_small=Is_AM_PM?'Images/img5.jpg':min[0]==2?'Images/img4.jpg':'Images/img26.jpg';
double height_small=20;

int default_layout=0;
var diff=0, second = DateFormat('ss').format(DateTime.now()),
    time_now = DateFormat('HH:mm:ss').format(DateTime.now());
List<int>min=[0,0,0];


String Pray=difference(time_now)[0]==0?"صلاه الفجر":difference(time_now)[0]==1?"الشروق":difference(time_now)[0]==2?"صلاه الظهر":
difference(time_now)[0]==3?"صلاه العصر":difference(time_now)[0]==4?"صلاه المغرب":"صلاه العشاء";


var colors=[Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70,Colors.white70];
Color color_selected=Colors.yellowAccent;
int color_selected_int;