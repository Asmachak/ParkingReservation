import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/src/utils/themes/widget_themes/text_theme.dart';

class TAppTheme {
  //make the constructor is private
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(brightness: Brightness.light,
  textTheme: TTextTheme.lightTextTheme,
    /*elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(())
    )*/
  );
  static ThemeData darkTheme = ThemeData(brightness: Brightness.dark,
      textTheme:TTextTheme.darkTextTheme ,
  );

}