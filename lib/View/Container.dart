import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/Calculate_AM_PM.dart';
import '../Model/Functions.dart';
import '../Model/UserSimplePreferences.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';



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
            fontSize: screen_width*0.095,
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
            fontSize: screen_width*0.11,
            fontFamily: 'BungeeShade',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

class future extends StatefulWidget {
  final AM_PM,Pray,color,screen_width,screen_height,index;
  future(this.AM_PM,this.Pray,this.color,this.screen_width,this.screen_height,this.index);

  @override
  _futureState createState() => _futureState(AM_PM,Pray,color,screen_width,screen_height,index);
}

class _futureState extends State<future>  {
  final AM_PM,Pray,color,screen_width,screen_height,index;
  _futureState(this.AM_PM,this.Pray,this.color,this.screen_width,this.screen_height,this.index);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieve_information();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String space = "                ", time = "00:00"; int t=0;double remain_percentage;
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
            }
            storeinformation();
          } else {
            if (Pray == "الفجر") {
              time=timer_Pray[0];
            } else if (Pray == "الشروق") {
              time=timer_Pray[1];
            } else if (Pray == "الظهر") {
              time=timer_Pray[2];
            } else if (Pray == "العصر") {
              time=timer_Pray[3];
            } else if (Pray == "المغرب") {
              time=timer_Pray[4];
            } else if (Pray == "العشاء") {
              time=timer_Pray[5];
            }
            var v=time.split(':');
            t=num.parse(v[0]);
            if(t>12){
              t=t-12;
              time="$t:${v[1]}";
            }
          }
          List<int>diff=difference(DateFormat('HH:mm:ss').format(DateTime.now()));
          List<int>prayer_period=Calculate_prayer_period();
          int now_time=diff[1]*60+diff[2];
          int first_time=prayer_period[index];

          int remain_index=diff[0];
          remain_percentage=(now_time/first_time)*100;
          //print("first_time = ${remain_percentage} \t index = ${index} \t remian index = ${remain_index}\n");
          return container_Pray("${time} ${AM_PM}","${Pray}",color,screen_width,screen_height,index,remain_index,remain_percentage);
        });
  }
}
Widget container_Pray(String text,String text2,Color color,double screen_width,double screen_height,int index,int remain_index,double percentage){
  percentage=1-(percentage/100);
  Color perc=percentage>=0.50?Colors.red:percentage>=0.30?Colors.yellow:Colors.green;
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(screen_width*0.02, screen_height*0.0004, screen_width*0.02, 0),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: screen_height*0.009,horizontal: screen_width*0.009),
      child: SizedBox(
        height: screen_height*0.07,
        child: LiquidLinearProgressIndicator(
          value: index==remain_index?percentage:100,
          valueColor: AlwaysStoppedAnimation(Colors.lightBlue[100]),
          backgroundColor: perc,
          borderRadius: screen_width*0.1,
          borderWidth: 2.0,
          borderColor: Colors.red,
          direction: Axis.vertical,
          center: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: screen_width*0.075,
                  fontFamily: 'font2',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: screen_width*0.14,),
              Text(
                text2,
                style: TextStyle(
                  fontSize: screen_width*0.075,
                  fontFamily: 'font2',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
}

Widget lastUpdatesContainer(Widget center,Color color) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          center,
        ],
      ),
    ),
  );
}