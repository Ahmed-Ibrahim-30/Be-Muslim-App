import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../ClassBuilder.dart';
import '../Model/Variable_declarations.dart';
import 'Azquar_Sapah.dart';
import 'home_page.dart';

class Drawer_screen extends StatefulWidget {
  final width,height;
  Drawer_screen(this.width,this.height);

  @override
  _Drawer_screenState createState() => _Drawer_screenState(this.width,this.height);
}

class _Drawer_screenState extends State<Drawer_screen> {
  final width,height;
  _Drawer_screenState(this.width,this.height);
  KFDrawerController _drawerController;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('Home_Page'),
      items: [
        KFDrawerItem.initWithPage(
          text: Text('أذكـــار الصـــبـــاح',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: ImageIcon(
            AssetImage("Images/img2.png"),
            color: Colors.red,
            size: width*0.08,
          ),
          page: ClassBuilder.fromString('Azquary_screen'),
        ),
        KFDrawerItem.initWithPage(
          text: Text('أذكـــار المـــســـــاء',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: ImageIcon(
            AssetImage("Images/img2.png"),
            color: Colors.red,
            size: width*0.08,
          ),
          page: ClassBuilder.fromString('Night_Azquar'),
        ),
        KFDrawerItem.initWithPage(
          text: Text('دعـــاء الاستـــخــاره',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: ImageIcon(
            AssetImage("Images/img2.png"),
            color: Colors.red,
            size: width*0.08,
          ),
          page: ClassBuilder.fromString('Doaa_istikhaarah'),
        ),
        KFDrawerItem.initWithPage(
          text: Text('Prayer Times',
              style: TextStyle(color: Colors.white, fontSize: width*0.04)),
          icon: ImageIcon(
            AssetImage("Images/img9.png"),
            color: Colors.white,
            size: width*0.08,
          ),
          page: ClassBuilder.fromString('Home_Page'),
        ),
      ],
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Padding(
          padding: const EdgeInsets.only(right: 120),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: EdgeInsets.only(right: width*0.003),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: width*0.2,),
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: ExactAssetImage('Images/img32.jpg'),
                    ),
                    SizedBox(height: height*0.004,),
                    Text(
                      "أَتَخْشَوْنَهُمْ ",
                      style: TextStyle(color: Colors.white54, fontSize: 19),
                    ),
                    Text(
                      'فَاللَّهُ  أَحَق  أَن تَخْشَوْهُ إِن كُنتُم مُّؤْمِنِين',
                      style: TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: kPrimaryColorTwo,
        ),
      ),
    );
  }
}
