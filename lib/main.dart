import 'package:flutter/material.dart';
import 'AppBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: Appbar(),
          body: Container(
            height: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                    ),
                    height: 300,
                    width: 100,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    child: Text("Child 1",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightGreen,
                        ),
                        height: 140,
                        width: 200,
                        margin: EdgeInsets.fromLTRB(0, 0, 12, 15),
                        child: Text("Child 2",style: TextStyle(color: Colors.white,fontSize: 20)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.cyan,
                        ),
                        height: 140,
                        width: 200,
                        margin: EdgeInsets.fromLTRB(0, 0, 12, 2),
                        child: Text("Child 3",style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
