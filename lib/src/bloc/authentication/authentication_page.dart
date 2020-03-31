import 'package:flutter/material.dart';

import 'index.dart';

class AuthenticationPage extends StatelessWidget {
  static const String routeName = "/authentication";
  AuthenticationPage();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    AuthenticationBloc _authenticationBloc = new AuthenticationBloc();
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          top: false,
          child: new AuthenticationScreen(
              authenticationBloc: _authenticationBloc)),
    );
  }


}
