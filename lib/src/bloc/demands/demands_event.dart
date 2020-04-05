import 'dart:async';

import 'package:dtaxi_driver/src/bloc/authentication/authentication_repository.dart';
import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DemandsEvent {
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc});

  final DemandsRepository _demandsRepository = new DemandsRepository();
  final AuthenticationRepository _authenticationRepository = new AuthenticationRepository();
}

class LoadDemandsEvent extends DemandsEvent {

  final bool api;

  LoadDemandsEvent({this.api});

  @override
  String toString() => 'LoadDemandsEvent';

  @override
  Future<DemandsState> applyAsync(
      {DemandsState currentState, DemandsBloc bloc}) async {
    try {
      var pending = await _demandsRepository.loadPendingDemands(api: this.api);
      var accepted = await _demandsRepository.loadDemandsByDriver(api: this.api);
      return InDemandsState(pending, accepted);
    } catch (_) {
      if(api){
        var pending = await _demandsRepository.loadPendingDemands();
        var accepted = await _demandsRepository.loadDemandsByDriver();
        return InDemandsState(pending, accepted, error: "Error de conexion");
      }
      else {
        return InDemandsState([], [], error: "Error cargando las demandas");
      }
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
      await _demandsRepository.acceptDemand(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending, accepted);
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
      await _demandsRepository.cancelDemand(demandId, cancelType,
          reason: reason);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending, accepted);
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
      var demand = await _demandsRepository.startDemand(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      if(demand.results.first != null && demand.results.first.driver.id != null)
        _authenticationRepository.updateDriverState(demand.results.first.driver.id, "NOAVAILABLE");
      return InDemandsState(pending, accepted);
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
      await _demandsRepository.declineDemand(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending, accepted);
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
      await _demandsRepository.pickUpClient(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      return InDemandsState(pending, accepted);
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
      var demand = await _demandsRepository.finishDemand(demandId);
      var pending = await _demandsRepository.loadPendingDemands();
      var accepted = await _demandsRepository.loadDemandsByDriver();
      if(demand.results.first != null && demand.results.first.driver.id != null)
        _authenticationRepository.updateDriverState(demand.results.first.driver.id, "AVAILABLE");
      return InDemandsState(pending, accepted);
    } catch (error, stacktrace) {
      if (error is GraphQLError && currentState is InDemandsState)
        return currentState.copyWith(error: error.message);
      print(stacktrace);
      return ErrorDemandsState(error?.toString());
    }
  }
}
