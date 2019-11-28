import 'dart:async';

import 'package:meta/meta.dart';

import 'index.dart';

@immutable
abstract class AuthenticationEvent {
  Future<AuthenticationState> applyAsync(
      {AuthenticationState currentState, AuthenticationBloc bloc});
  final AuthenticationRepository _authenticationRepository =
      new AuthenticationRepository();
}

class LoginInitAuthenticationEvent extends AuthenticationEvent {
  @override
  String toString() => 'LoadAuthenticationEvent';

  @override
  Future<AuthenticationState> applyAsync(
      {AuthenticationState currentState, AuthenticationBloc bloc}) async {
    try {
      return new InAuthenticationState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorAuthenticationState(_?.toString());
    }
  }
}

class LoginAuthenticationEvent extends AuthenticationEvent {
  final String username;
  final String password;

  LoginAuthenticationEvent(this.username, this.password);

  @override
  Future<AuthenticationState> applyAsync(
      {AuthenticationState currentState, AuthenticationBloc bloc}) async {
    try {
      var response = await _authenticationRepository.login(username, password);

      ///Save Token
      ///response.results.first.token
      return new InAuthenticationState();
    } catch (_, stackTrace) { 
      print('$_ $stackTrace');
      return new ErrorAuthenticationState(_?.toString());
    }
  }
}
