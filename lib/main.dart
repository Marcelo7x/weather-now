import 'package:flutter/material.dart';
import 'package:mobile_weather/telaInicial.dart';
import 'package:mobile_weather/telaPrevisao.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  //home: TelaInicial(),
  theme: ThemeData(accentColor: Colors.deepOrange),
  initialRoute: '/',
  routes: {
    //'TelaCarregamento' : (context) => TelaPrincipal(),
    '/' : (context) => TelaInicial(),
    'telaPrevisao': (context) => TelaPrevisao(Map)
  }
));