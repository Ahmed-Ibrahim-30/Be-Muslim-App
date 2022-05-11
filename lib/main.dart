import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_splash/custom_splash.dart';
import 'ClassBuilder.dart';
import 'Model/UserSimplePreferences.dart';
import 'View/Drawer.dart';
import 'View/home_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';


Future main() async{
  ClassBuilder.registerClasses();

  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    if (a > 100)
      return 1;
    else
      return 2;
  };
  Map<int, Widget> op = {1: MyApp(), 2: MyApp()};
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
    home: CustomSplash(
      imagePath: 'Images/img9.png',
      backGroundColor: Colors.cyanAccent,
      animationEffect: 'zoom-in',//zoom-in ,zoom-out ,fade-in ,top-down
      logoSize: 1600,
      home: MyApp(),
      customFunction: duringSplash,
      duration: 2000,
      type: CustomSplashType.StaticDuration,
      outputAndHome: op,
    ),
    debugShowCheckedModeBanner: false,
  )
  );
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.teal.withOpacity(0.7),
    ));

    return Drawer_screen(width,height);
  }

}


