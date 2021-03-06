import 'dart:async';

import 'package:bloc/bloc.dart';

import 'index.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  static final AuthenticationBloc _authenticationBlocSingleton =
      new AuthenticationBloc._internal();
  factory AuthenticationBloc() {
    return _authenticationBlocSingleton;
  }
  AuthenticationBloc._internal();

  AuthenticationState get initialState => new UnAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  @override
  Future<Function> close() {
    _authenticationBlocSingleton.close();
    return super.close();
  }


}
