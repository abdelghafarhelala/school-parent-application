import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parent_app/shared/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: GoogleFonts.elMessiri().fontFamily,
  appBarTheme: AppBarTheme(
    // systemOverlayStyle: const SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarBrightness: Brightness.light,
    //     statusBarIconBrightness: Brightness.light),
    // backgroundColor: Colors.white,

    iconTheme: const IconThemeData(color: lightTextColor),
    titleTextStyle: GoogleFonts.elMessiri(
      textStyle: const TextStyle(
          color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    toolbarTextStyle: const TextStyle(
      color: lightTextColor,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      suffixIconColor: Colors.grey,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300]!,
        ),
      ),
      fillColor: Colors.grey,
      hoverColor: Colors.grey,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(
          color: Colors.white,
        ),
      ),
      border: OutlineInputBorder(),
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
      iconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      hintStyle: const TextStyle(color: Colors.grey)),
  primarySwatch: Palette.kToDark,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amber,
    textTheme: ButtonTextTheme.primary,
  ),
  primaryColor: primaryColor,
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
  )),
  textTheme: TextTheme(
      button: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      // subtitle1: TextStyle(
      //   fontSize: 17,
      //   color: Colors.red,
      // ),

      subtitle2: const TextStyle(
          fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w800),
      subtitle1: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      bodyText1: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: HexColor('#121721'),
      ),
      headline1: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      headline2: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
      caption: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      )),
  cardColor: Colors.white,
  cardTheme: const CardTheme(
    elevation: 5,
    shadowColor: Colors.grey,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 5,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true),
  toggleableActiveColor: primaryColor,
  unselectedWidgetColor: Colors.grey,
);

//////////////////////////////////////////Dark Theme /////////////////////////////////////
ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: lightTextColor),
      titleTextStyle: TextStyle(
          color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
      color: darkColor,
      toolbarTextStyle: TextStyle(
        color: lightTextColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
        suffixIconColor: Colors.grey,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        fillColor: Colors.grey,
        hoverColor: Colors.grey,
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        labelStyle: TextStyle(color: Colors.grey),
        iconColor: Colors.grey,
        prefixIconColor: Colors.grey,
        hintStyle: TextStyle(color: Colors.grey)),
    primarySwatch: Palette.kToDark,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.amber,
      textTheme: ButtonTextTheme.primary,
      alignedDropdown: true,
      disabledColor: Colors.grey,
      hoverColor: Colors.grey,
    ),
    scaffoldBackgroundColor: darkColor,
    primaryColor: primaryColor,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
    )),
    textTheme: const TextTheme(
      button: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      // subtitle1: TextStyle(
      //   fontSize: 17,
      //   color: Colors.red,
      // ),
      subtitle2: TextStyle(
        fontSize: 17,
        color: primaryColor,
      ),
      bodyText1: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
      headline1: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
      caption: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white))),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.grey,
    ),
    cardColor: Colors.black87,
    cardTheme: const CardTheme(
      elevation: 5,
      shadowColor: Colors.grey,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(86, 63, 63, 64),
        elevation: 10,
        selectedIconTheme: IconThemeData(
          color: primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true),
    toggleableActiveColor: primaryColor,
    unselectedWidgetColor: Colors.grey,
    canvasColor: Colors.grey,
    hintColor: Colors.grey);
