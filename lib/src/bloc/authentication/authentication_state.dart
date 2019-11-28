import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([Iterable props]) : super(props);

  /// Copy object for use in action
  AuthenticationState getStateCopy();
}

/// UnInitialized
class UnAuthenticationState extends AuthenticationState {
  @override
  String toString() => 'UnAuthenticationState';

  @override
  AuthenticationState getStateCopy() {
    return UnAuthenticationState();
  }
}

/// Initialized
class InAuthenticationState extends AuthenticationState {
  @override
  String toString() => 'InAuthenticationState';

  AuthenticationState getStateCopy() {
    return InAuthenticationState();
  }
}

class LoggedInAuthenticationState extends AuthenticationState {
  @override
  AuthenticationState getStateCopy() {
    // TODO: implement getStateCopy
    return null;
  }
}

class ErrorAuthenticationState extends AuthenticationState {
  final error;

  ErrorAuthenticationState(this.error);

  @override
  String toString() => 'ErrorAuthenticationState';

  ErrorAuthenticationState getStateCopy() {
    return ErrorAuthenticationState(error);
  }
}
