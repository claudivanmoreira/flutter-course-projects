import 'package:flutter/material.dart';

class CalculadoraImc extends StatefulWidget {
  CalculadoraImc({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalculadoraImcState createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {
  static final _defaultTextResult = {
    "value": "Informe seus dados.",
    "color": Colors.black
  };

  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  var _textResultado = _defaultTextResult;
  var _formImcKey = GlobalKey<FormState>();

  _resetTextFields() {
    _weightController.text = "";
    _heightController.text = "";
    setState(() {
      _textResultado = _defaultTextResult;
      _formImcKey = GlobalKey<FormState>(); // Reseta as mensagens de erro
    });
  }

  _calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;
    double imc = (weight / (height * height));
    setState(() {
      if (imc < 18.6) {
        _textResultado = {
          "value": "Abaixo do peso (${imc.toStringAsPrecision(4)})",
          "color": Colors.blue
        };
      } else if (imc >= 18.6 && imc < 24.9) {
        _textResultado = {
          "value": "Peso Ideal (${imc.toStringAsPrecision(4)})",
          "color": Colors.green
        };
      } else if (imc >= 24.9 && imc < 29.9) {
        _textResultado = {
          "value": "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})",
          "color": Colors.amber
        };
      } else if (imc >= 29.9 && imc < 34.9) {
        _textResultado = {
          "value": "Obesidade Grau I (${imc.toStringAsPrecision(4)})",
          "color": Colors.red
        };
      } else if (imc >= 34.9 && imc < 39.9) {
        _textResultado = {
          "value": "Obesidade Grau II (${imc.toStringAsPrecision(4)})",
          "color": Colors.red
        };
      } else if (imc >= 40) {
        _textResultado = {
          "value": "Obesidade Grau III (${imc.toStringAsPrecision(4)})",
          "color": Colors.red
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetTextFields)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formImcKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Image.asset(
                  "images/dieta.png",
                  height: 60,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  validator: (value) =>
                      value.isEmpty ? "Informe seu peso" : null,
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: "Peso (em kg)",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: TextFormField(
                  validator: (value) =>
                      value.isEmpty ? "Informe sua altura" : null,
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      labelText: "Altura (em cm)",
                      labelStyle: TextStyle(color: Colors.green, fontSize: 16)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formImcKey.currentState.validate()) {
                        _calculateImc();
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Text(
                _textResultado["value"],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _textResultado["color"],
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
