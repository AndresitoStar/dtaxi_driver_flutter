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
  var obscurePassword = true;

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

    return Theme(
      data: Theme.of(context).copyWith(brightness: Brightness.dark),
      child: Container(
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
                  Icon(Icons.local_taxi, size: 80, color: Colors.white),
                  Text(
                    "D'TAXI",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Form(
                      child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(labelText: "usuario"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          style: TextStyle(color: Colors.white),
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                              labelText: "contraseña",
                              suffixIcon: GestureDetector(
                                child: Icon(Icons.remove_red_eye),
                                onLongPressStart: (_) {
                                  setState(() {
                                    obscurePassword = false;
                                  });
                                },
                                onLongPressEnd: (_) {
                                  setState(() {
                                    obscurePassword = true;
                                  });
                                },
                              )),
                        ),
                      )
                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            widget.loginCallback("chacho", "123456");
                          },
                          child: Text("Continuar".toUpperCase()),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
