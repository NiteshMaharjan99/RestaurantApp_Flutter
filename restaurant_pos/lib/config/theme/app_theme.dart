import 'package:flutter/material.dart';

import 'app_color_constant.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme() {
    return ThemeData(
       colorScheme:  ColorScheme.light(
        primary: AppColorConstant.primaryColor,
      ),

      fontFamily: "Open Sans",
      useMaterial3: true,
      
      appBarTheme:  AppBarTheme(
        elevation: 0,
        backgroundColor: AppColorConstant.appBarColor,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 26,
        ),
      ),

      bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        backgroundColor: AppColorConstant.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

       elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: AppColorConstant.primaryColor,
          textStyle: const TextStyle(
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
           
        ),
      ),

      inputDecorationTheme:  InputDecorationTheme(
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(),
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColorConstant.primaryColor,
          ),
        ),
      ),
    );


  }
}
