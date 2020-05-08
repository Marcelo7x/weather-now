import 'package:flutter/material.dart';
import 'package:mobile_weather/fade_animation.dart';


class TelaPrevisao extends StatelessWidget {
var _data;

TelaPrevisao(this._data);
Map _imagemTempo = {'normal' : AssetImage('images/tempo/tempoNormal.jpg'),
    'calor' : AssetImage('images/tempo/tempoCalor.jpg'),
    'frio' : AssetImage('images/tempo/tempoFrio.jpg'),
    'chuva' : AssetImage('images/tempo/tempoChuva.jpg'),
  'humidade' : AssetImage('images/humidity.png'),
  'vento' : AssetImage('images/wind.png'),
  'porDoSol' : AssetImage('images/sunrise.png')
  };

  _imagemTema(){

    //print(_data);
    switch (_data['results']['description']) {
      case 'Chuva':
        return  _imagemTempo['chuva'];
        break;
      default: 
        if (_data['results']['temp'] > 25) {
          return _imagemTempo['calor'];
      } 
          else if (_data['results']['temp'] < 19) {
            return _imagemTempo['frio'];
      }     
            else {
              return _imagemTempo['normal'];
      }
    }
  }

  _proximosDias(int dia, BuildContext context){
    return FadeIn(2, Container(
      width: MediaQuery.of(context).size.width * 0.20,
      height: MediaQuery.of(context).size.height * 0.13,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '${_data['results']['forecast'][dia]['weekday']}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w100,
              fontFamily: 'sans',
              decoration: TextDecoration.none
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                '${_data['results']['forecast'][dia]['max']}º',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'sans',
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.none,
                ),
              ),

              Text(
                '/',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'sans',
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.none
                ),
              ),

              Text(
                '${_data['results']['forecast'][dia]['min']}º',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'sans',
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.none
                ),
              )
            ],
          ),

          Text(
            '${_data['results']['forecast'][dia]['description']}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w100,
                fontFamily: 'sans',
                decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _alturaTela = MediaQuery.of(context).size.height;
    double _larguraTela = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        height: _alturaTela,
        width: _larguraTela,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              FadeIn(1, Container(
                  margin: EdgeInsets.only(top: _alturaTela*0.04),
                  width: _larguraTela * 0.95,
                  height: _alturaTela * 0.13,
                  //color: Colors.black12,
                    decoration:  BoxDecoration(
                      color: Colors.black12,
                      image: DecorationImage(
                        image: _imagemTema(),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken)
                      ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[900],
                          blurRadius: 5
                        )
                      ]
                    ),
                   child: Stack(
                     children: <Widget> [
                       Container(
                         height: _alturaTela * 0.13,
                         width: _larguraTela * 0.95,
                          padding: EdgeInsets.only(
                            left: 20, right: 20
                          ),
                         decoration: BoxDecoration(
                           gradient: RadialGradient(
                             colors: [
                               Colors.black12,
                               Colors.black87
                             ],
                             radius: 3
                           )
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget> [
                               Row(
                                 children: <Widget>[
                                   Text(
                                     '${_data['results']['city_name']}', //Nome cidade
                                     textAlign: TextAlign.start,
                                     style: TextStyle(
                                         wordSpacing: 0,
                                         fontSize: 36,
                                         fontFamily: 'sans',
                                         fontWeight: FontWeight.bold,
                                         color: Colors.white,
                                         decoration: TextDecoration.none,
                                         shadows: [
                                           Shadow(
                                               color: Colors.black,
                                               blurRadius: 5,
                                               offset: Offset(4, 2)
                                           )
                                         ]
                                     ),
                                   ),

                                 ],
                               ),
                         Text(
                            ' ${_data['results']['description']}', //Nome cidade
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                wordSpacing: 0,
                                fontSize: 18,
                                fontFamily: 'sans',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      blurRadius: 3,
                                      offset: Offset(2, 2)
                                  )
                                ]
                            ),
                          ),
                        ]
                      ),
                     ),
                    ]
                   )
                )),

                Container(
                  width: _larguraTela,
                  height: _alturaTela * 0.83,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FadeIn(2,Container(
                             width: _larguraTela * 0.90,
                             height: _alturaTela *0.14,
                             margin: EdgeInsets.only(top: 25),
                             //alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: Color.fromRGBO(15,15,15,1),
                               boxShadow: [
                                 BoxShadow(
                                   color: Color.fromRGBO(10,10,10,1),
                                   blurRadius: 5
                                 )
                               ],
                               borderRadius: BorderRadius.only(
                                 topLeft: Radius.circular(25),
                                 topRight: Radius.circular(90),
                                 bottomLeft: Radius.circular(90),
                                 bottomRight: Radius.circular(25),
                               ),
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: <Widget>[
                                     Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget> [
                                         Padding(
                                           padding: EdgeInsets.only(left: 40, top: 0),
                                           child: Text(
                                             '${_data['results']['temp']}℃',
                                             style: TextStyle(
                                               fontSize: 46,
                                               fontFamily: 'sans',
                                               color: Colors.white,
                                               fontWeight: FontWeight.w100,
                                               decoration: TextDecoration.none
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(left: 10, top: 7),
                                           child: Text(
                                             '${_data['results']['forecast'][0]['max']}º',
                                             style: TextStyle(
                                                 fontSize: 20,
                                                 fontFamily: 'sans',
                                                 color: Colors.orangeAccent,
                                                 fontWeight: FontWeight.w100,
                                                 decoration: TextDecoration.none
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(top: 12),
                                           child: Text(
                                             '/',
                                             style: TextStyle(
                                                 fontSize: 25,
                                                 fontFamily: 'sans',
                                                 color: Colors.white,
                                                 fontWeight: FontWeight.w100,
                                                 decoration: TextDecoration.none
                                             ),
                                           ),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(top: 20),
                                           child: Text(
                                             '${_data['results']['forecast'][0]['min']}º',
                                             style: TextStyle(
                                                 fontSize: 20,
                                                 fontFamily: 'sans',
                                                 color: Colors.blueAccent,
                                                 fontWeight: FontWeight.w100,
                                                 decoration: TextDecoration.none
                                             ),
                                           ),
                                         ),
                                       ]
                                     ),
                                     Padding(
                                       padding: EdgeInsets.only(top: _alturaTela * 0.02, right: _larguraTela * 0.10),
                                       child: Icon(
                                         Icons.wb_sunny,
                                         color: Colors.white,
                                         size: 35,
                                       ),
                                     ),
                                   ],
                                 ),
                                 Padding(
                                   padding: EdgeInsets.only(left: _larguraTela * 0.02, right: _larguraTela * 0.02),
                                   child: Text(
                                       '${_data['results']['forecast'][0]['description']}',
                                     style: TextStyle(
                                         fontSize: 14,
                                         fontFamily: 'sans',
                                         color: Colors.white,
                                         fontWeight: FontWeight.w100,
                                         decoration: TextDecoration.none
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                      )),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeIn(3, Container(
                            width: _larguraTela * 0.46,
                            height: _alturaTela *0.14,
                            margin: EdgeInsets.only(top: 25, right: 3),
                            //alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(15,15,15,1),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(10,10,10,1),
                                    blurRadius: 5
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 28,
                                  width: 28,
                                  child: Image(
                                    image: _imagemTempo['humidade'],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                      child: Text(
                                        'Humidade',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'sans',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w100,
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                      child: Text(
                                        '${_data['results']['humidity']}%',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontFamily: 'sans',
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w100,
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                            ),
                          )),
                          FadeIn(3.5, Container(
                            width: _larguraTela * 0.46,
                            height: _alturaTela *0.14,
                            margin: EdgeInsets.only(top: 25, left: 3),
                            //alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(15,15,15,1),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(10,10,10,1),
                                    blurRadius: 5
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 28,
                                    width: 28,
                                    child: Image(
                                      image: _imagemTempo['vento'],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                        child: Text(
                                          'Velocida do vento',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'sans',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w100,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                        child: Text(
                                          '${_data['results']['wind_speedy']}',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'sans',
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w100,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                            ),
                          )),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeIn(4, Container(
                            width: _larguraTela * 0.46,
                            height: _alturaTela *0.14,
                            margin: EdgeInsets.only(top: 25, right: 3),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(15,15,15,1),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(10,10,10,1),
                                  blurRadius: 5
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ) ,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: 28,
                                  width: 28,
                                  child: RotatedBox(
                                    quarterTurns: 2,
                                    child: Image(
                                      image: _imagemTempo['porDoSol'],
                                    ),
                                  ),
                                ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                        child: Text(
                                          'Nascer do sol',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'sans',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w100,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                        child: Text(
                                          '${_data['results']['sunrise']}',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'sans',
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w100,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                            ),
                          )),
                          FadeIn(4.5, Container(
                            width: _larguraTela * 0.46,
                            height: _alturaTela *0.14,
                            margin: EdgeInsets.only(top: 25, left: 3),
                            //alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(15,15,15,1),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(10,10,10,1),
                                    blurRadius: 5
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 28,
                                    width: 28,
                                    child: Image(
                                      image: _imagemTempo['porDoSol'],

                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                        child: Text(
                                          'Pôr do sol',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'sans',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w100,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: _larguraTela * 0.0),
                                        child: Text(
                                          '${_data['results']['sunset']}',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'sans',
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w100,
                                              decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                            ),
                          )),
                        ],
                      ),

                    FadeIn(6, Container(
                        width: _larguraTela * 0.95,
                        height: _alturaTela *0.18,
                        margin: EdgeInsets.only(top: 25),
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(15,15,15,1),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(10,10,10,1),
                                blurRadius: 5
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(90),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(90),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                _proximosDias(1, context),
                                _proximosDias(2, context),
                                _proximosDias(3, context),
                              ],
                            ),
                          ],
                        ),
                      )),

                      FadeIn(6, Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:  25),
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'Weather Now',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                  fontFamily: 'sans',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top:  20, left: 2),
                            child: Icon(
                              Icons.copyright,
                              color: Colors.white,
                              size: 12,
                            ),
                          )
                        ],
                      ))
                    ]
                  )
                ),

              ],
            ),
          ),
    );
  }
}