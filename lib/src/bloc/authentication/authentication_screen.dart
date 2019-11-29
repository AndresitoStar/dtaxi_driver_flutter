import 'package:dtaxi_driver/src/ui/homepage.dart';
import 'package:dtaxi_driver/src/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    Key key,
    @required AuthenticationBloc authenticationBloc,
  })  : _authenticationBloc = authenticationBloc,
        super(key: key);

  final AuthenticationBloc _authenticationBloc;
  @override
  AuthenticationScreenState createState() {
    return new AuthenticationScreenState(_authenticationBloc);
  }
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  final AuthenticationBloc _authenticationBloc;
  AuthenticationScreenState(this._authenticationBloc);

  @override
  void initState() {
    super.initState();
    this._authenticationBloc.dispatch(LoginInitAuthenticationEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: widget._authenticationBloc,
        builder: (
          BuildContext context,
          AuthenticationState currentState,
        ) {
          if (currentState is UnAuthenticationState)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (currentState is InAuthenticationState)
            return LoginScreen(
              loginCallback: (username, password) => widget._authenticationBloc
                  .dispatch(LoginAuthenticationEvent(username, password)),
            );
          else if (currentState is ErrorAuthenticationState)
            return Container();
          else
            return Homepage(
              title: "Bandeja de Entrada",
            );
        });
  }
}
