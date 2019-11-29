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
  TextEditingController _passCtrl;
  FocusNode _userNode = FocusNode();
  FocusNode _passNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var obscurePassword = true;

  @override
  void initState() {
    _userCtrl = new TextEditingController();
    _passCtrl = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              autocorrect: false,
                              controller: _userCtrl,
                              focusNode: _userNode,
                              cursorColor: Theme.of(context).cursorColor,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(labelText: "usuario"),
                              validator: (text) =>
                                  text == "" ? "Campo requerido" : null,
                              onEditingComplete: () {
                                _passNode.requestFocus();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              autocorrect: false,
                              controller: _passCtrl,
                              focusNode: _passNode,
                              cursorColor: Theme.of(context).cursorColor,
                              style: TextStyle(color: Colors.white),
                              obscureText: obscurePassword,
                              validator: (text) =>
                                  text == "" ? "Campo requerido" : null,
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
                          onPressed: () => _formKey.currentState.validate()
                              ? widget.loginCallback(
                                  _userCtrl.text, _passCtrl.text)
                              : null,
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
