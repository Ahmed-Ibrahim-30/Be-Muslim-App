import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import '../Model/Variable_declarations.dart';
import 'Container.dart';
class Azquary_screen extends KFDrawerContent {

  @override
  _Azquary_screenState createState() => _Azquary_screenState();
}

class _Azquary_screenState extends State<Azquary_screen> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: height*0.008,horizontal:width*0.023 ),
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
                ),Colors.teal.withOpacity(0.4))
            ),
            SizedBox(height: height*0.007,),
            Container(

              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
              ),
              child: Image.asset("Images/sapah.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
