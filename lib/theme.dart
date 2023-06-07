import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
  primaryColor:  Colors.cyan,
  iconTheme: const IconThemeData(
    color: Colors.cyan,
    size: 25,
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.cyan,
  ),
);
