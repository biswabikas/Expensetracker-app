import 'package:flutter/material.dart';
import 'package:third_app/expenses.dart';
import 'package:flutter/services.dart';
var kcolorscheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));
var kdarkcolorscheme=ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 99, 125));
void main(){
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(useMaterial3: true,
    colorScheme: kdarkcolorscheme,
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(fontWeight: FontWeight.normal,color: kcolorscheme.onSecondaryContainer),
    ),
    cardTheme: CardTheme().copyWith(
      color: kdarkcolorscheme.secondaryContainer,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8)
    )),
    theme: ThemeData().copyWith(useMaterial3: true,
    colorScheme:kcolorscheme,
    appBarTheme: AppBarTheme().copyWith(
      backgroundColor:kcolorscheme.onPrimaryContainer,
      foregroundColor: kcolorscheme.primaryContainer
    ),
    cardTheme: CardTheme().copyWith(
      color: kcolorscheme.secondaryContainer,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kcolorscheme.primaryContainer
      )
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(fontWeight: FontWeight.normal,color: kcolorscheme.onSecondaryContainer,fontSize: 14)
    )),
    themeMode: ThemeMode.system,
    home: Expenses(),
  ));
}