import 'package:flutter/material.dart';
import 'hexcolor.dart';

final ThemeData appThemeData = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: HexColor('#2A39E1'),
  accentColor: const Color.fromRGBO(38,116,251,1),
  // fontFamily: 'NotoSansTC',
  brightness: Brightness.light,
  appBarTheme: _appbarTheme(),

  textSelectionTheme:TextSelectionThemeData(
    cursorColor: HexColor('#2A39E1')
  ) ,
  iconTheme: IconThemeData(
    color: Colors.blue
  ),
  textTheme: TextTheme(

    bodyText1: TextStyle(fontSize: 12),
    headline1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
  ),
);

AppBarTheme _appbarTheme() {
  return AppBarTheme(

    centerTitle: true,
    // color: new Color.fromRGBO(38,116,251,1),
    color: Colors.white,
    // color: HexColor('#2A39E1'),
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color:HexColor('#333333')),  // 图标
  );
}