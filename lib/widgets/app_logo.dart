import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const AppLogo({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            Image.asset("assets/images/logo_transparent.png", height: height ?? 70));
  }
}
