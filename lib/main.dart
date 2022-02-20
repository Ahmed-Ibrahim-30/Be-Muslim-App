import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'AppBar.dart';
import 'dart:async';
import 'Calculate_AM_PM.dart';
import 'Container.dart';
import 'Functions.dart';
import 'package:audioplayers/audioplayers.dart';
import 'Variable_declarations.dart';
void main() {
  runApp(MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  TimeOfDay timeOfDay = TimeOfDay.now();
  void initState() {
    int last_index=0,count=0; bool enter=false;
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (second != DateTime.now().second) {
        setState(() {
            if(enter)count++;
            time_now = DateFormat('HH:mm:ss').format(DateTime.now());
            last_index=min[0];
            min=difference(time_now);
            if(last_index!=min[0])colors[last_index]=Colors.white70;
            diff=59-DateTime.now().second;
            time_now=Calculate_time(diff, min[1], min[2]);
            if(min[0]==0) {
              Pray="صلاه الفجر";
              PM(0);
              Is_AM_PM=true;
            }
            else if(min[0]==1) {
              Pray="الشروق";
              Is_AM_PM=false;
              AM(1);
            }
            else if(min[0]==2) {
              Pray="صلاه الظهر";
              Is_AM_PM=false;
              AM(2);
            }
            else if(min[0]==3) {
              Pray="صلاه العصر";
              Is_AM_PM=false;
              AM(3);
            }
            else if(min[0]==4) {
              Pray="صلاه المغرب";
              Is_AM_PM=true;
              PM(4);
            }
            else if(min[0]==5) {
              Pray="صلاه العشاء";
              Is_AM_PM=true;
              PM(5);
            }
            if(time_now=='00:00:00' && min[0]!=1 && !enter){
              default_layout=1;
              Pray_index=min[0];
              count=0; enter=true;
              AudioCache player=new AudioCache(prefix: 'sound/');
              if(Pray_index==0) {player.play('Fajr.mp3'); sound_duration=232;}
              else if(Pray_index==2 ) {player.play('adhan.mp3'); sound_duration=210;}
              else if(Pray_index==3 ) {player.play('adhan1.mp3'); sound_duration=250;}
              else if(Pray_index==4 ||Pray_index==5) {player.play('adhan2.mp3'); sound_duration=127;}
            }
            if(sound_duration==count){
              default_layout=0;
              enter=false;
              count=0;
            }
          }
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String period = timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    var duhur=timer_Pray[2].split(":"); int duhur_hour=num.parse(duhur[0]);
    String Dhuhr_period = duhur_hour < 12 ? "AM" : "PM";
    return Scaffold(
         // appBar: Appbar(width,height,context),
          body: default_layout==0?Container(
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                image: new ExactAssetImage(backgroundimage),
                colorFilter: new ColorFilter.mode(background_color, BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child:Appbar(width,height,context),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(width*0.045, height*0.012, width*0.045, height*0.012),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*0.18),
                              image: DecorationImage(
                                image:AssetImage(background_small),
                                colorFilter: new ColorFilter.mode(Colors.red.withOpacity(0.6), BlendMode.dstOut),
                                fit: BoxFit.cover,
                              ),
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height:height*0.03,),
                                container("باقي علي $Pray", remain_color, width,height),
                                container_time(
                                    time_now, Colors.black87,width,height),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(width*0.045, height*0.012, width*0.045, height*0.012),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.09),
                          color: Colors.black12),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child:future("AM","الفجر",colors[0],width,height,0)
                          ),
                          Expanded(
                            flex: 1,
                            child:future("AM","الشروق",colors[1],width,height,1),
                          ),
                          Expanded(
                              flex: 1,
                              child:future("${Dhuhr_period}","الظهر",colors[2],width,height,2)
                          ),
                          Expanded(
                              flex: 1,
                              child: future("PM","العصر",colors[3],width,height,3)
                          ),
                          Expanded(
                              flex: 1,
                              child: future("PM","المغرب",colors[4],width,height,4)
                          ),
                          Expanded(
                              flex: 1,
                              child: future("PM","العشاء",colors[5],width,height,5)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ):Layout(Pray_index,width,height),
    );
  }
}
