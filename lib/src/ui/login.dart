import 'package:flutter/material.dart';

typedef LoginCallback(String username, String password);

class LoginScreen extends StatefulWidget {
  final LoginCallback loginCallback;

  const LoginScreen({Key key, this.loginCallback}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userCtrl;

  @override
  void initState() {
    _userCtrl = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    );

    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            "assets/images/bg_splash.jpg",
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Icon(Icons.local_taxi, size: 80, color: Colors.white),
              Text(
                "D'TAXI",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: inputDecoration.copyWith(
                        labelText: "usuario",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: inputDecoration,
                  )
                ],
              )),
              RaisedButton(
                onPressed: () {
                  widget.loginCallback("chacho", "123456");
                },
                child: Text("Login"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
