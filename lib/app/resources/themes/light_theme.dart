import 'package:flutter/material.dart';
import 'package:me_weather/app/resources/font_manager.dart';

class LightTheme {
  static get getTheme => ThemeData(
        canvasColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white, size: FontSize.s30),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.blue[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        ),
        cardTheme: CardTheme(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
      );
}
