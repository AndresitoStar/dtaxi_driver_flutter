import 'package:flutter/material.dart';

typedef ErrorCalback();

class ErrorScreen extends StatelessWidget {
  final String message;
  final ErrorCalback callback;


  ErrorScreen({this.message, this.callback});

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/images/bg_splash.jpg",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 85,
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: Icon(Icons.error, color: Colors.red, size: 80.0,)
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: calculateMargin(heigth, 85+50)),
                  child: Center(
                    child: Text(message.replaceAll("Exception:", ""), style: TextStyle(color: Colors.white, fontSize: 30.0),),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () => this.callback,
                        child: Text("Volver".toUpperCase()),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double calculateMargin(double heigth, int used) {
    double remaining = heigth - used;
    if(remaining - 150 > 100) return 150;
    if(remaining - 100 > 100) return 100;
    if(remaining - 50 > 100) return 50;
    if(remaining - 25 > 100) return 25;
    if(remaining - 10 > 100) return 10;
    return 0;
  }
}