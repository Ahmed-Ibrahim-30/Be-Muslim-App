import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'AppBar.dart';
import 'Calculate_AM_PM.dart';
import 'Variable_declarations.dart';
import 'data.dart';
import 'jsonconnection.dart';
import 'Container.dart';
import 'main.dart';

String city = 'Giza';
String country = 'Egypt';
int method = 5;

JsonConnection jsonConnection = new JsonConnection();
Data list;
final String url =
    "http://api.aladhan.com/v1/timingsByCity?city=Giza&country=Egypt%20Arab%20Emirates&method=5";

Future getPTData() async {
  var res = await http.get(Uri.parse(Uri.encodeFull(url)));
  final data = jsonDecode(res.body);

  list = Data.fromJson(data);

  return list;
}

List<int> difference(String time_now) {
  var diff = [
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0],
    [0, 0]
  ];
  var substr_now = time_now.split(":"), substr;
  int hournow = num.parse(substr_now[0]),
      Minute_now = num.parse(substr_now[1]),
      hour = 0,
      Minute = 0;
  int hour_diff = 0,
      Minute_diff = 0,
      Second_diff = num.parse(substr_now[2]),
      index = 0;

  for (int i = 0; i < timer_Pray.length; i++) {
    substr = timer_Pray[i].split(":");
    hour = num.parse(substr[0]);
    Minute = num.parse(substr[1])-1;

    hour_diff = hour - hournow;
    if (hour_diff < 0) hour_diff = hour + (24 - hournow);

    Minute_diff = Minute - Minute_now;
    if (Minute_diff < 0) {
      Minute_diff = Minute + (60 - Minute_now);
      if (hour_diff == 0)
        hour_diff = 23;
      else
        hour_diff--;
    }

    diff[i][0] = hour_diff;
    diff[i][1] = Minute_diff;
  }
  hour_diff = diff[0][0];
  Minute_diff = diff[0][1];
  for (int i = 0; i < 5; i++) {
    if (hour_diff > diff[i + 1][0]) {
      hour_diff = diff[i + 1][0];
      Minute_diff = diff[i + 1][1];
      index = i + 1;
    } else if (hour_diff == diff[i + 1][0] && Minute_diff > diff[i + 1][1]) {
      hour_diff = diff[i + 1][0];
      Minute_diff = diff[i + 1][1];
      index = i + 1;
    }
  }
  return [index, hour_diff, Minute_diff];
}

Calculate_time(int diff, int hour, int minute) {
  String sec = "", hou = "", m = "";
  if (diff < 10)
    sec = "0$diff";
  else
    sec = "$diff";
  if (hour < 10)
    hou = "0${hour}";
  else
    hou = "${hour}";
  if (minute < 10)
    m = "0${minute}";
  else
    m = "${minute}";

  return "$hou:$m:$sec";
}

Widget getlocation(double screen_width) {
  return FutureBuilder(
      future: getPTData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          {
            return Text(
              '${snapshot.data.data.meta.timezone}',
              style: TextStyle(
                  color: Is_AM_PM ? Colors.red : Colors.blue,
                  fontSize: screen_width * 0.05),
            );
          }
        } else {
          return CircularProgressIndicator(
            color: Colors.white,
          );
        }
      });
}

void AM(int num) {
  if (num == 2) {
    backgroundimage = 'Images/img25.jpg';
    background_small = 'Images/img4.jpg';
  } else {
    backgroundimage = 'Images/img29.jpg';
    background_small = 'Images/img26.jpg';
  }
  height_small = 40;
  background_color = Colors.black.withOpacity(0.4);
  remain_color = Colors.lightGreen[900];
  for (int i = 0; i < colors.length; i++) {
    if (i == num)
      colors[i] = Colors.lightBlue[600];
    else
      colors[i] = Colors.white60;
  }
}

void PM(int num) {
  backgroundimage = 'Images/img7.jpg';
  background_small = 'Images/img5.jpg';
  height_small = 20;
  background_color = null;
  remain_color = Colors.teal[200];

  for (int i = 0; i < colors.length; i++) {
    if (i == num) {
      colors[i] = color_selected;
      color_selected_int=i;
    } else
      colors[i] = Colors.white70;
  }
}

Widget Layout(int num, double screenwidth, double screenheight) {
  String image = "";

  if (num == 0)
    image = 'Images/fajr2.jpg';
  else if (num == 2)
    image = 'Images/img32.jpg';
  else if (num == 3)
    image = 'Images/asr1.jpg';
  else if (num == 4)
    image = 'Images/maghrib1.jpg';
  else if (num == 5) image = 'Images/isha2.jpg';

  return Container(
    height: double.infinity,
    width: screenwidth,
    alignment: Alignment.topCenter,
    decoration: BoxDecoration(
      color: const Color(0xff7c94b6),
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.5), BlendMode.dstATop),
        image: new ExactAssetImage(image),
        fit: BoxFit.fill,
      ),
    ),
    child: Container(
      margin: EdgeInsets.only(top: screenheight * 0.05),
      child: num == 2 ?
      Container(
        width: screenwidth,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white30,
          boxShadow: [
            BoxShadow(
              color: Colors.green[100],
              spreadRadius: 10,
              blurRadius: 9,
            )
          ]
        ),
        child: Text(
          'حان الان موعد اذان الظهر',
          style: TextStyle(
            color: Colors.teal,
            fontSize: screenwidth * 0.071,
            fontFamily: 'font6',
            fontWeight: FontWeight.bold,
          ),
          textAlign:TextAlign.center,
        ),
      ): null,
    ),
  );
}