import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../Model/Variable_declarations.dart';
import 'Container.dart';

class Doaa_istikhaarah extends KFDrawerContent {

  @override
  _Doaa_istikhaarahState createState() => _Doaa_istikhaarahState();
}

class _Doaa_istikhaarahState extends State<Doaa_istikhaarah> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow.withOpacity(0.3),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: height*0.009,horizontal:width*0.053 ),
                child: lastUpdatesContainer(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu_rounded),
                        onPressed: widget.onMenuPressed,
                      ),
                    ),
                    Center(
                      child: ScaleAnimatedTextKit(
                        text: [
                          "سبــحـــان  الـلـــه",
                          "الحـــمــد  الــلــه",
                          "صـــلــي عـلـي الـنـبـي",
                          "لا اله إلا الله",
                          "الــلــه   أكـــبــر"
                        ],
                        duration: Duration(seconds: 6),
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ArefRuqaa',
                            fontSize: width * 0.069+height*0.009,
                            color: Colors.pink
                        ),
                      ),
                    ),
                    ImageIcon(
                      AssetImage("Images/img1.png"),
                      color: Colors.blue,
                      size: height * 0.038+width*0.008,
                    ),
                  ],
                ),Appbar_background)
            ),
            SizedBox(height: height*0.06,),
            lastUpdatesContainer(
                Text(
                    "اللهم إني أستخيرك بعلمك، وأستقدرك بقدرتك، وأسألك من فضلك العظيم، فإنك تقدر ولا أقدر، وتعلم ولا أعلم، وأنت علام الغيوب، اللهم إن كنت تعلم أن هذا الأمر (ويُسميه بعينه من زواجٍ أو سفرٍ أو غيرهما) خير لي في ديني ومعاشي وعاقبة أمري فاقدره لي، ويسره لي، ثم بارك لي فيه، وإن كنت تعلم أن هذا الأمر شرّ لي في ديني ومعاشي وعاقبة أمري فاصرفه عني، واصرفني عنه، واقدر لي الخير حيث كان، ثم أرضني به",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: width*0.06
                  ),
                ),
                Colors.red.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
