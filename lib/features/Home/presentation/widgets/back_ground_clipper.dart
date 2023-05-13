import 'package:flutter/material.dart';

class BackGroundClipper extends CustomClipper<Path>{
  double radiusOfCurvetureOfPath;
  BackGroundClipper({required this.radiusOfCurvetureOfPath});
  @override
  Path getClip(Size size) {
    final Path path=Path();
    double h=size.height;
    double w=size.width;
    path.moveTo(0, radiusOfCurvetureOfPath);
    path.lineTo(0, h);
    path.quadraticBezierTo( 0,h-radiusOfCurvetureOfPath,radiusOfCurvetureOfPath, h-radiusOfCurvetureOfPath);
    path.lineTo(w-radiusOfCurvetureOfPath, h-radiusOfCurvetureOfPath);
    path.quadraticBezierTo( w,h-radiusOfCurvetureOfPath,w,h);
    path.lineTo(w, radiusOfCurvetureOfPath);
    path.quadraticBezierTo(w, 0, w-radiusOfCurvetureOfPath, 0);
    path.lineTo(radiusOfCurvetureOfPath, 0);
    path.quadraticBezierTo(0, 0, 0, radiusOfCurvetureOfPath);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}