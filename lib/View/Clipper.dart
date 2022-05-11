import 'package:flutter/material.dart';

class Clipper_Appbar extends CustomClipper<Path>{
  final height;
  Clipper_Appbar(this.height);
  @override
  Path getClip(Size size) {
    Path path=Path();
    path.lineTo(0, height-200);
    path.quadraticBezierTo((size.width)/2, size.height, size.width,(height)-200);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

}