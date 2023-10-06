import 'package:flutter/material.dart';

final ThemeData AppTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(250, 247, 235, 1),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color.fromRGBO(127, 0, 25, 1)),
    tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          color: Color.fromRGBO(127, 0, 25, 1).withOpacity(0.2),
          borderRadius: BorderRadius.circular(30.0),
        ),
        unselectedLabelColor: Color.fromRGBO(204, 204, 204, 1),
        labelPadding: EdgeInsets.only(left: 20.0, right: 20.0),
        labelColor: Color.fromRGBO(127, 0, 25, 1)),
    // drawerTheme:
    //     DrawerThemeData(backgroundColor: Color.fromRGBO(127, 0, 25, 1)),
    primaryColor: Color.fromRGBO(127, 0, 25, 1),
    primaryColorLight: Color.fromRGBO(204, 204, 204, 1));
