import 'package:flutter/material.dart';

class TCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
   // throw UnimplementedError();
   var path = Path();
   // start point
   path.lineTo(0, size.height);

   // creating Shape
     // Shape 1
   final firstCurve = Offset(0, size.height -20);
   final lastCurve = Offset(30, size.height -20);

   path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

   // Straight Line
   // ignore: non_constant_identifier_names
   final SecondFirstCurve = Offset(0, size.height -20);
   // ignore: non_constant_identifier_names
   final SecondLastCurve = Offset(size.width-30, size.height -20);

   path.quadraticBezierTo(SecondFirstCurve.dx, SecondFirstCurve.dy, SecondLastCurve.dx, SecondLastCurve.dy);

     // Shape 2
   final thirdFirstCurve = Offset(size.width, size.height -20);
   final thirdLastCurve = Offset(size.width, size.height);

   path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdLastCurve.dx, thirdLastCurve.dy);


   path.lineTo(size.width, 0);
   path.close();
   return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    // throw UnimplementedError();
    return true;
  }

}