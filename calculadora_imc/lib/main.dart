import 'package:calculadora_imc/screens/calculadora_imc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CalcularodaImcApp());
}

class CalcularodaImcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculadoraImc(title: 'Calculadora IMC'),
    );
  }
}
