import 'dart:async';
import 'dart:developer';

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
  @override
  String toString() => 'LoadDemandsEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending.results, accepted.results);
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
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending.results, accepted.results);
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
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending.results, accepted.results);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}

class StartDemandEvent extends DemandsEvent {
  final String demandId;

  StartDemandEvent(this.demandId);

  @override
  String toString() => 'StartDemandEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = await _demandsRepository.startDemand(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending.results, accepted.results);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}

class DeclineDemandEvent extends DemandsEvent {
  final String demandId;

  DeclineDemandEvent(this.demandId);

  @override
  String toString() => 'DeclineDemandEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = await _demandsRepository.declineDemand(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending.results, accepted.results);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}

class PickUpDemandEvent extends DemandsEvent {
  final String demandId;

  PickUpDemandEvent(this.demandId);

  @override
  String toString() => 'DeclineDemandEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = await _demandsRepository.pickUpClient(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending.results, accepted.results);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}

class FinishDemandEvent extends DemandsEvent {
  final String demandId;

  FinishDemandEvent(this.demandId);

  @override
  String toString() => 'DeclineDemandEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var response = await _demandsRepository.finishDemand(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending.results, accepted.results);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}
