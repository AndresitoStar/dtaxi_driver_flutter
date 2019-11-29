import 'dart:async';

import 'package:dtaxi_driver/src/bloc/utils/secure_storage.dart';
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
      var token = await SecureStorage.getToken();
      if (token != null && token != "")
        return LoggedInAuthenticationState();
      else
        return InAuthenticationState();
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
      SecureStorage.saveToken(response.results.first.token);

      return new LoggedInAuthenticationState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorAuthenticationState(_?.toString());
    }
  }
}
