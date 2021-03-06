import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/bg_splash.jpg",
          fit: BoxFit.fitHeight,
        ),
        Positioned(
            top: MediaQuery.of(context).size.height / 2.5,
            left: (MediaQuery.of(context).size.width - 80) / 2,
            child: Column(
              children: <Widget>[
                Icon(Icons.local_taxi, size: 80, color: Colors.white),
                Text(
                  "D'TAXI",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text("Pal login"),
                )
              ],
            )),
      ],
    ))));
  }
}
