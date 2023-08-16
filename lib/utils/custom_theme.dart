import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: HexColor('0a1227'),
        fontFamily: 'OpenSans',
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          bodyText1: _bodyText1Light,
          bodyText2: _bodyText2Light,
          caption: _captionLight,
          headline1: _headline1Light,
          headline2: _headline2Light,
          headline3: _headline3Light,
          headline4: _headline4Light,
          headline5: _headline5Light,
          headline6: _headline6Light,
          button: _buttonLight,
          overline: _overlineLight,
          subtitle1: _subtitle1Light,
          subtitle2: _subtitle2Light,
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(_buttonLight))),
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          buttonColor: Colors.red,
        ));
  }

  static TextStyle get _bodyText1Light => const TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 18,
      );
  static TextStyle get _bodyText2Light => const TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 18,
      );

  static TextStyle get _captionLight => const TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 18,
      );

  static TextStyle get _overlineLight => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 21,

      fontWeight: FontWeight.w500);

  static TextStyle get _headline1Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 23,
      letterSpacing: 1,
      fontWeight: FontWeight.w500);

  static TextStyle get _headline2Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 21,
      fontWeight: FontWeight.w500);

  static TextStyle get _headline3Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 19,
      fontWeight: FontWeight.w500);

  static TextStyle get _headline4Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 17,
      fontWeight: FontWeight.w500);

  static TextStyle get _headline5Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static TextStyle get _headline6Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 14,
      fontWeight: FontWeight.w500);

  static TextStyle get _buttonLight => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 15,
      fontWeight: FontWeight.w500);

  static TextStyle get _subtitle1Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 14,
      fontWeight: FontWeight.w500);

  static TextStyle get _subtitle2Light => const TextStyle(
      color: Colors.white,
      fontFamily: 'OpenSans',
      fontSize: 21,
      fontWeight: FontWeight.w500);
}
