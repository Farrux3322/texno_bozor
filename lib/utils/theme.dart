import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:texno_bozor/utils/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.C_1C0B0B,
    appBarTheme:const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),
      centerTitle: true,
      backgroundColor:AppColors.C_1C0B0B,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.C_1C0B0B,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
}
