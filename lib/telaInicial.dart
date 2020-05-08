import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:mobile_weather/telaPrevisao.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:mobile_weather/fade_animation.dart';



class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool _local = false;
  bool teste = false;
  Position _posicao;
  var _logo = AssetImage('images/weatherNow.png');
  TextEditingController _cidadeBusca = TextEditingController();

  _widgetCidade({String estado, Map data}){
    if (estado == 'cidadeTrue'){
      print('true');
      //print(data);
      //Map data1 = data['results'];
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => TelaPrevisao(data))  
    );
    } else if(estado == null) {
      print('null');
      return Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.065,
          bottom: MediaQuery.of(context).size.height * 0.050
        ),
        width: MediaQuery.of(context).size.width*0.90,
        height: MediaQuery.of(context).size.height * 0.07,
        padding: EdgeInsets.only(left: 18),
        decoration: BoxDecoration(

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(70),
            ),
          color: Colors.grey[900],
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(10,10,10,1),
              blurRadius: 5,
              offset: Offset(-1, 4),
              spreadRadius: -4
            )
          ]
        ),
        child: TextField(
          controller: _cidadeBusca,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 0),
            icon: GestureDetector(
              onTap: ()=> _localizacao(),
              child: Icon(
                Icons.location_on,
                color: Colors.red[600],
              ),
            ),
            hintText: 'Sua cidade',
            hintStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700]
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.grey[300],
          ),
        )
      );
    } else if (estado == 'cidadeCarregamento'){
      print('entrei aki');
      return Container(
        margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.065,
        bottom: MediaQuery.of(context).size.height * 0.050
        ),
        width: MediaQuery.of(context).size.height * 0.07,
        height: MediaQuery.of(context).size.height * 0.07,
        color: Colors.transparent,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    } else if (estado == 'cidadeErro'){
      return showDialog<void> (
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Ops!!!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.redAccent
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Algo deu errado, não encontramos sua cidade :(',
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,left: 8, right: 8),
                    child: Text(
                      'Verifique e tente novamente.',
                      
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Voltar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _widgetCidade();
                  });
                },
              ),
            ],
          );
        }
      );
    }
  }

   _localizacao() async {
    print('loc');
    teste = true;
    setState(() {
      //_widgetCidade(estado: 'cidadeCarregamento');
    });
    _posicao = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    _local = true;
    print(_posicao.toString());
    _botaoPesquisa();
    //List retorno = [posicao.latitude.toString(), posicao.latitude.toString()];
     //teste = false;
  }

  _botaoPesquisa() async {
    print('pes');
    teste = true;
    setState(() {
      //_widgetCidade(estado: 'cidadeCarregamento');

    });

    Future<Map<dynamic,dynamic>> datas = _requisicaoHttp();
    Map previsaoJson = await datas.then((a) => a);

  print(previsaoJson);
    if (previsaoJson['by'] == 'default') {
      setState(() {
        _widgetCidade(estado: 'cidadeErro');
        teste = false;
      });
    } else {
      setState(() {
        _widgetCidade(estado: 'cidadeTrue', data: previsaoJson);
      });
    }
    //teste = false;
  }

  Future<Map> _requisicaoHttp() async{
    print('bus');
    //await Future.delayed(Duration(seconds: 3), (){});
    String _nomeCidade = _cidadeBusca.text;
    String _urlApi;
    if (_local) {
      print('b');
      _urlApi ='https://api.hgbrasil.com/weather?format=json-cors&key=3839bf4e&lat=${_posicao.latitude.toString()}&log=${_posicao.longitude.toString()}&user_ip=remote';
    }
    else {
      print('a');
      _urlApi = 'https://api.hgbrasil.com/weather?format=json-cors&locale=pt&city_name=$_nomeCidade&key=3839bf4e';
    }

    var _data = await http.get(_urlApi);
    return json.decode(_data.body);
    //print(json.decode(_data.body));
    //Map dataTeste = {"by":"default","valid_key":true,"results":{"temp":24,"date":"26/04/2020","time":"14:13","condition_code":"30","description":"Parcialmente nublado","currently":"dia","cid":"","city":"Acaiaca, MG","img_id":"30","humidity":61,"wind_speedy":"4 km/h","sunrise":"6:07 am","sunset":"5:33 pm","condition_slug":"cloudly_day","city_name":"Acaiaca","forecast":[{"date":"26/04","weekday":"Dom","max":25,"min":16,"description":"Parcialmente nublado","condition":"cloudly_day"},{"date":"27/04","weekday":"Seg","max":24,"min":15,"description":"Ensolarado com muitas nuvens","condition":"cloudly_day"},{"date":"28/04","weekday":"Ter","max":24,"min":13,"description":"Ensolarado","condition":"clear_day"},{"date":"29/04","weekday":"Qua","max":25,"min":13,"description":"Parcialmente nublado","condition":"cloudly_day"},{"date":"30/04","weekday":"Qui","max":26,"min":13,"description":"Ensolarado com muitas nuvens","condition":"cloudly_day"},{"date":"01/05","weekday":"Sex","max":27,"min":13,"description":"Ensolarado","condition":"clear_day"},{"date":"02/05","weekday":"Sáb","max":27,"min":15,"description":"Ensolarado","condition":"clear_day"},{"date":"03/05","weekday":"Dom","max":26,"min":15,"description":"Ensolarado","condition":"clear_day"},{"date":"04/05","weekday":"Seg","max":25,"min":17,"description":"Parcialmente nublado","condition":"cloudly_day"},{"date":"05/05","weekday":"Ter","max":26,"min":17,"description":"Parcialmente nublado","condition":"cloudly_day"}]},"execution_time":0.17,"from_cache":false};
    //return dataTeste;
    //print(_urlApi);
  }
  List ai;
  @override
  void initState() {
    // TODO: implement initState
    //_localizacao();


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.black
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //padding: EdgeInsets.only(top: 40),
            children: <Widget>[
              FadeIn(1.5,
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height*0.50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple[900],
                        Colors.deepPurple[600]
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple,
                        blurRadius: 5
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.09),
                        width: 300,
                        height:200,
                        decoration: BoxDecoration(
                        ),
                        child: FadeIn(5, Image(image: _logo)),
                      )
                    ],
                  )
                ),
              ),

               !teste ? FadeIn(3, _widgetCidade()) : _widgetCidade(estado: 'cidadeCarregamento'),

              FadeIn(4,
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.040),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.deepPurple[900],
                        Colors.deepPurple[400]
                      ]
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(70),
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(20),
                    )
                  ),
                  child: FlatButton(
                    onPressed: () => _botaoPesquisa(),
                    child: Text('Buscar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            blurRadius: 5
                          )
                        ]
                      ),
                    ),
                  )
                )
              ),

              FadeIn(5, Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Essa é uma aplicação de fim educacional,'
                  ' unicamente para colocar em prática conceitos por mim aprendidos '
                  'do framework Flutter baseado na linguagem Dart. \n\nMarcelo Nascimento',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                    fontFamily: 'sans',
                    decoration: TextDecoration.none,
                    color: Colors.grey[100]
                  ),
                  textAlign: TextAlign.justify,
                ),
              )),
            ],
          ),
        )
      ),
    );    
  }
}