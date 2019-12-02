import 'dart:async';

import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DemandsEvent {
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc});

  final DemandsRepository _demandsRepository = new DemandsRepository();
}

class LoadDemandsEvent extends DemandsEvent {
  final bool demandsByDriver;

  LoadDemandsEvent({this.demandsByDriver = false});

  @override
  String toString() => 'LoadDemandsEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = demandsByDriver
          ? await _demandsRepository.loadDemandsByDriver()
          : await _demandsRepository.loadPendingDemands();
      return InDemandsState(response.results);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorDemandsState(_?.toString());
    }
  }
}

class AcceptDemandEvent extends DemandsEvent {
  final String demandId;

  AcceptDemandEvent(this.demandId);

  @override
  String toString() => 'AcceptDemandEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = await _demandsRepository.acceptDemand(demandId);
      return InDemandsState(response.results);
    } catch (error) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      return ErrorDemandsState(error?.toString());
    }
  }
}
