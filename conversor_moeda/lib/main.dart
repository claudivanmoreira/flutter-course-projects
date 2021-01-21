import 'package:conversor_moeda/screens/conversor_de_moeda.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Conversor de Moeda",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
    home: ConversorDeMoeda(),
  ));
}
