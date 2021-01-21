import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiUrl = "https://api.hgbrasil.com/finance?key=a9eac041";

class ConversorDeMoeda extends StatefulWidget {
  ConversorDeMoeda({Key key}) : super(key: key);

  @override
  _ConversorDeMoedaState createState() => _ConversorDeMoedaState();
}

class _ConversorDeMoedaState extends State<ConversorDeMoeda> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  double cotacaoDolar;
  double cotacaoDoEuro;

  _realChanged(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }
    double valorEmReal = double.parse(value);
    dolarController.text = (valorEmReal / cotacaoDolar).toStringAsFixed(2);
    euroController.text = (valorEmReal / cotacaoDoEuro).toStringAsFixed(2);
  }

  _dolarChanged(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }
    double valorEmDolar = double.parse(value);
    realController.text = (valorEmDolar * this.cotacaoDolar).toStringAsFixed(2);
    euroController.text =
        (valorEmDolar * this.cotacaoDolar / this.cotacaoDoEuro)
            .toStringAsFixed(2);
  }

  _euroChanged(String value) {
    if (value.isEmpty) {
      _clearAll();
      return;
    }
    double valorEmEuro = double.parse(value);
    realController.text = (valorEmEuro * this.cotacaoDoEuro).toStringAsFixed(2);
    dolarController.text =
        (valorEmEuro * this.cotacaoDoEuro / this.cotacaoDolar)
            .toStringAsFixed(2);
  }

  _clearAll() {
    realController.clear();
    dolarController.clear();
    euroController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getCotacoes(),
          initialData: [],
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando Dados...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
                break;
              default:
                this.cotacaoDolar =
                    snapshot.data["results"]["currencies"]["USD"]["buy"];
                this.cotacaoDoEuro =
                    snapshot.data["results"]["currencies"]["EUR"]["buy"];
                if (snapshot.hasError) {
                  final error = snapshot.error;
                  return Center(
                    child: Text(
                      "Erro ao Carregar Dados :( : ${error.toString()}",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 100,
                          color: Colors.amber,
                        ),
                        buildTextField(
                            "Reais", "R\$ ", realController, _realChanged),
                        Divider(),
                        buildTextField(
                            "Dólares", "US\$ ", dolarController, _dolarChanged),
                        Divider(),
                        buildTextField(
                            "Euros", "€\$ ", euroController, _euroChanged),
                      ],
                    ),
                  );
                }
                break;
            }
          }),
    );
  }
}

TextField buildTextField(String labelText, String prefixText,
    TextEditingController fieldController, Function onChangeHandler) {
  return TextField(
    controller: fieldController,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefixText,
    ),
    style: TextStyle(
      color: Colors.amber,
    ),
    onChanged: onChangeHandler,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    autofocus: false,
  );
}

Future<Map> getCotacoes() async {
  final response = await http.get(apiUrl);
  return json.decode(response.body);
}
