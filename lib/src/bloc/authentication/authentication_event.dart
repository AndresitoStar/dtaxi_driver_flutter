import 'dart:async';

import 'package:dtaxi_driver/src/bloc/localization/localization_bloc.dart';
import 'package:dtaxi_driver/src/bloc/localization/localization_events.dart';
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
      var response = await _authenticationRepository.login(
          username.trim(), password.trim());
      var user = response.results.first;
      if (user.role["name"] == "DRIVER") {
        SecureStorage.saveToken(response.results.first.token);
        SecureStorage.saveUserAndPass(username, password);
        SecureStorage.saveUserData(response.results.first);
        return new LoggedInAuthenticationState();
      } else
        return ErrorAuthenticationState("No es usuario Driver");
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorAuthenticationState(_?.toString());
    }
  }
}

class LogoutAuthenticationEvent extends AuthenticationEvent {
  @override
  Future<AuthenticationState> applyAsync(
      {AuthenticationState currentState, AuthenticationBloc bloc}) async {
    try {
      var user = await SecureStorage.getUserData();
      if (user != null && user.driver != null && user.driver.id != null &&
          user.driver.state == "AVAILABLE") {
        AuthenticationRepository().updateDriverState(
            user.driver.id, "NOAVAILABLE").then((_) {
          LocalizationBloc().add(StopLocationBroadcastEvent());
          SecureStorage.removeToken();
        });
      } else {
        SecureStorage.removeToken();
      }
      return new InAuthenticationState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorAuthenticationState(_?.toString());
    }
  }
}
