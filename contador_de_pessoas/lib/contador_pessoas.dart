import 'package:flutter/material.dart';

class ContadorDePessoas extends StatefulWidget {
  ContadorDePessoas({Key key}) : super(key: key);

  @override
  ContadorDePessoasState createState() => ContadorDePessoasState();
}

class ContadorDePessoasState extends State<ContadorDePessoas> {
  static final _podeEntrarState = {
    "text": "Pode Entrar",
    "color": Colors.green
  };
  static final _naoPodeEntrarState = {
    "text": "Não Pode Entrar",
    "color": Colors.red
  };

  String _infoJogoText = _podeEntrarState["text"];
  Color _infoJogoColor = _podeEntrarState["color"];
  int _qtdePessoas = 0;

  ContadorDePessoasState();

  void _changeQtdePessoas(int delta) {
    final sum = _qtdePessoas + delta;
    setState(() {
      _qtdePessoas =
          (sum >= 0 && sum <= 5) ? _qtdePessoas += delta : _qtdePessoas;
      if (sum > 5) {
        _infoJogoText = _naoPodeEntrarState["text"];
        _infoJogoColor = _naoPodeEntrarState["color"];
      } else {
        _infoJogoText = _podeEntrarState["text"];
        _infoJogoColor = _podeEntrarState["color"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/cs_go.png",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Center(
          child: Container(
            color: Color.fromRGBO(35, 39, 35, 0.8),
            constraints: BoxConstraints(maxWidth: 300, maxHeight: 200),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Quantidade de Pessoas: $_qtdePessoas',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          onPressed: () => _changeQtdePessoas(1),
                          child: Text(
                            "+1",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                          onPressed: () => _changeQtdePessoas(-1),
                          child: Text(
                            "-1",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _infoJogoText,
                    style: TextStyle(
                        color: _infoJogoColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
