import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dtaxi_driver/src/bloc/demands/index.dart';

class DemandsBloc extends Bloc<DemandsEvent, DemandsState> {
  static final DemandsBloc _demandsBlocSingleton = new DemandsBloc._internal();

  factory DemandsBloc() {
    return _demandsBlocSingleton;
  }

  DemandsBloc._internal();

  DemandsState get initialState => new UnDemandsState();

  @override
  Stream<DemandsState> mapEventToState(
    DemandsEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }
}
