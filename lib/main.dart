import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alturaController = new TextEditingController();
  TextEditingController pesoController = new TextEditingController();
  String _info = "Informe os dados";

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  void _resetForm() {
    alturaController.text = "";
    pesoController.text = "";
    setState(() {
      _info = "Informe os dados";
      _globalKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;

      double imc = peso / (altura * altura);
      if (imc < 18.0) {
        _info = "Menor que 18 - ${imc.toStringAsPrecision(4)}";
      } else if (imc < 25.0) {
        _info = "Menor que 25 - ${imc.toStringAsPrecision(4)}";
      } else {
        _info = "Maior ou igual a 25 - ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo da calculadora"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            onPressed: _resetForm,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.adb,
                  size: 120.0,
                  color: Colors.purple,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencher o peso";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso",
                      labelStyle: TextStyle(color: Colors.cyanAccent)),
                  style: TextStyle(color: Colors.red, fontSize: 50.0),
                  textAlign: TextAlign.center,
                  controller: pesoController,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencher a altura";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura",
                      labelStyle: TextStyle(color: Colors.cyanAccent)),
                  style: TextStyle(color: Colors.red, fontSize: 50.0),
                  textAlign: TextAlign.center,
                  controller: alturaController,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Container(
                    height: 150.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_globalKey.currentState.validate()) {
                          _calcular();
                        }
                      },
                      child: Text("Calcular"),
                      color: Colors.red,
                    ),
                  ),
                ),
                Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
