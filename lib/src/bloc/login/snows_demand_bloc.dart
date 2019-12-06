import 'dart:async';

import 'package:bloc/bloc.dart';

import 'index.dart';

class SDemandBloc extends Bloc<SDemandEvent, SDemandState> {
  static final SDemandBloc _sDemandBlocSingleton = new SDemandBloc._internal();
  factory SDemandBloc() {
    return _sDemandBlocSingleton;
  }
  SDemandBloc._internal();

  SDemandState get initialState => new UnSDemandState();

  @override
  Stream<SDemandState> mapEventToState(
    SDemandEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }
}
