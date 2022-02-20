import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Variable_declarations.dart';
import 'package:untitled2/main.dart';
import 'Calculate_AM_PM.dart';
import 'Functions.dart';


Widget container(String text, Color color,double screen_width,double screen_height) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(screen_width*0.04,Is_AM_PM? screen_height*0.02:screen_height*0.03, screen_width*0.04,screen_height*0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              backgroundBlendMode: BlendMode.hardLight,
              color: Colors.white10,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green[100],
                    spreadRadius: 7,
                    blurRadius: 9,
                  )
                ]
            ),

            child: ImageIcon(
              AssetImage("Images/img2.png"),
              color: Colors.red[800],
              size: screen_width*0.08,
            ),
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: screen_width*0.1,
            fontFamily: 'font4',
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(left: 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              backgroundBlendMode: BlendMode.hardLight,
              color: Colors.white54,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green[100],
                    spreadRadius: 5,
                    blurRadius: 9,
                  )
                ]
            ),
            child: ImageIcon(
              AssetImage("Images/img0.png"),
              color: Colors.red[900],
              size: screen_width*0.08,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget container_time(String text, Color color,double screen_width,double screen_height) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white24,
        boxShadow: [
          BoxShadow(
            color: Colors.white10,
            spreadRadius: 8,
            blurRadius: 12,
          )
        ]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: screen_width*0.12,
            fontFamily: 'BungeeShade',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

List<String> timer_Pray = ["05:06", "06:30", "12:09", "15:30", "17:46", "19:04"];
Widget future(String AM_PM, String Pray,Color color,double screen_width,double screen_height,int index ) {
  String space = "                ", time = ""; int t=0;
  return FutureBuilder(
      future: getPTData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          {
            if (Pray == "الفجر") {
              time = snapshot.data.data.timings.fajr;
              timer_Pray[0] = time;
            } else if (Pray == "الشروق") {
              time = snapshot.data.data.timings.sunrise;
              timer_Pray[1] = time;
            } else if (Pray == "الظهر") {
              time = snapshot.data.data.timings.dhuhr;
              timer_Pray[2] = time;
            } else if (Pray == "العصر") {
              time = snapshot.data.data.timings.asr;
              timer_Pray[3] = time;
            } else if (Pray == "المغرب") {
              time = snapshot.data.data.timings.maghrib;
              timer_Pray[4] = time;
            } else if (Pray == "العشاء") {
              time = snapshot.data.data.timings.isha;
              timer_Pray[5] = time;
            }
            var v=time.split(':');
            t=num.parse(v[0]);
            if(t>12){
              t=t-12;
              time="$t:${v[1]}";
            }
            return container_Pray("${time} ${AM_PM}${space}${Pray}",color,screen_width,screen_height,index);
          }
        } else {
          if (Pray == "الفجر") {
            time = timer_Pray[0];
          } else if (Pray == "الشروق") {
            time = timer_Pray[1];
          } else if (Pray == "الظهر") {
            time = timer_Pray[2];
          } else if (Pray == "العصر") {
            time = timer_Pray[3];
          } else if (Pray == "المغرب") {
            time = timer_Pray[4];
          } else if (Pray == "العشاء") {
            time = timer_Pray[5];
          }
          var v=time.split(':');
          t=num.parse(v[0]);
          if(t>12){
            t=t-12;
            time="$t:${v[1]}";
          }
          return container_Pray("${time} ${AM_PM}${space}${Pray}",color,screen_width,screen_height,index);
        }
      });
}

Widget container_Pray(String text,Color color,double screen_width,double screen_height,int index){
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlue[100],
            spreadRadius: 2,
            blurRadius: 3,
          )
        ],
    ),
    margin: EdgeInsets.fromLTRB(screen_width*0.02, screen_height*0.013, screen_width*0.02, screen_height*0.009),
    child: Text(
      text,
      style: TextStyle(
          fontSize: screen_width*0.08,
        fontFamily: 'font2',
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}