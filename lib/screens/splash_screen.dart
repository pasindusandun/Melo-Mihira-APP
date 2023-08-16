import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:optimum_music/screens/home_screen.dart';
import 'package:optimum_music/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future _init() async {
    await Future.delayed(const Duration(seconds: 3));
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('0A1227'),
      body: Center(
          child: AppLogo(
        height: _size.height * 0.1,
      )),
    );
  }
}
