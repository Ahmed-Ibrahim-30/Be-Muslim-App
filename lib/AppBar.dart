import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Functions.dart';
import 'Calculate_AM_PM.dart';

String text = "${Icons.location_on}";

PreferredSizeWidget Appbar(double width, double height, BuildContext context) {
  return AppBar(
    toolbarHeight: 130,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    flexibleSpace: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          gradient: LinearGradient(
              colors: [Colors.teal[200], Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.fromLTRB(6, 38, 0, 0),
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Is_AM_PM ? Colors.red : Colors.blue,
                      size: width * 0.08,
                    ),
                    getlocation(width),
                  ],
                )),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(0, 30, 6, 0),
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "مواقيت الصلاة",
                  style: TextStyle(
                      color: Is_AM_PM ? Colors.red : Colors.blue,
                      fontFamily: 'ArefRuqaa',
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.079),
                ),
                SizedBox(
                  width: 5,
                ),
                ImageIcon(
                  AssetImage("Images/img1.png"),
                  color: Is_AM_PM ? Colors.red : Colors.blue,
                  size: width * 0.068,
                ),
              ],
            ),
          )),
        ],
      ),
    ),

    //
  );
}
