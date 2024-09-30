import 'package:flutter/material.dart';

class InnerRightCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 30);
    path.quadraticBezierTo(
      size.width - size.width * 0.15,
      size.height + size.height * 0.1,
      size.width - size.width * 0.9,
      size.height,
    );
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
