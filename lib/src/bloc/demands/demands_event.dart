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
      List<Demand> prev = (currentState as InDemandsState).demands
        ..removeWhere((d) => d.id == response.results.first.id);

      return new InDemandsState(prev);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}

class CancelDemandEvent extends DemandsEvent {
  final String demandId;
  final String cancelType;
  final String reason;

  CancelDemandEvent(this.demandId, this.cancelType, {this.reason});

  @override
  String toString() => 'CancelDemandEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = await _demandsRepository.cancelDemand(demandId, cancelType,
          reason: reason);
      List<Demand> prev = (currentState as InDemandsState).demands
        ..remove(response.results.first);

      return InDemandsState(prev);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}
