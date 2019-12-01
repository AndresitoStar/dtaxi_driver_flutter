import 'dart:async';

import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DemandsEvent {
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc});

  final DemandsRepository _demandsRepository = new DemandsRepository();
}

class LoadDemandsEvent extends DemandsEvent {
  @override
  String toString() => 'LoadDemandsEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = await this._demandsRepository.loadDemands();
      return InDemandsState(response.results);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorDemandsState(_?.toString());
    }
  }
}
