import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget Appbar(){
  return AppBar(
    backgroundColor: Colors.amber,
    title: Text("Task 1",
      style: TextStyle(
        color: Colors.red
    ),),
  );
}