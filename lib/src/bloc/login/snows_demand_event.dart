import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dtaxi_driver/src/bloc/authentication/authentication_model.dart';
import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:meta/meta.dart';

import 'index.dart';

@immutable
abstract class SDemandEvent {
  Future<SDemandState> applyAsync(
      {SDemandState currentState, SDemandBloc bloc});
}

class InitSDemandEvent extends SDemandEvent {
  @override
  String toString() => 'InitSDemandEvent';

  @override
  Future<SDemandState> applyAsync(
      {SDemandState currentState, SDemandBloc bloc}) async {
    try {
      return UnSDemandState();
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return new ErrorSDemandState(_?.toString());
    }
  }
}

class LoadSDemandEvent extends SDemandEvent {
  @override
  String toString() => 'LoadSDemandEvent';

  @override
  Future<SDemandState> applyAsync(
      {SDemandState currentState, SDemandBloc bloc}) async {
    try {
      var provider = DemandProvider();
      var pending = await provider.findDemand("http://10.0.2.2:3002/pending");
      var accepted = await provider.findDemand("http://10.0.2.2:3002/accepted");

      return InPenddingDemandState(pending, accepted);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return currentState;
    }
  }
}

class AcceptSDemandEvent extends SDemandEvent {
  @override
  String toString() => 'AcceptSDemandEvent';

  @override
  Future<SDemandState> applyAsync(
      {SDemandState currentState, SDemandBloc bloc}) async {
    try {
      var provider = DemandProvider();
      var pending = await provider.findDemand("http://10.0.2.2:3002/pending");
      var accepted = await provider.findDemand("http://10.0.2.2:3002/accepted");

      return InPenddingDemandState(pending, accepted);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return currentState;
    }
  }
}

class CancelSDemandEvent extends SDemandEvent {
  @override
  String toString() => 'CancelSDemandEvent';

  @override
  Future<SDemandState> applyAsync(
      {SDemandState currentState, SDemandBloc bloc}) async {
    try {
      var provider = DemandProvider();
      var pending = await provider.findDemand("http://10.0.2.2:3002/pending");
      var accepted = await provider.findDemand("http://10.0.2.2:3002/accepted");

      return InPenddingDemandState(pending, accepted);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return currentState;
    }
  }
}

class StartSDemandEvent extends SDemandEvent {
  @override
  String toString() => 'CancelSDemandEvent';

  @override
  Future<SDemandState> applyAsync(
      {SDemandState currentState, SDemandBloc bloc}) async {
    try {
      var provider = DemandProvider();
      var pending = await provider.findDemand("http://10.0.2.2:3002/pending");
      var accepted = await provider.findDemand("http://10.0.2.2:3002/accepted");

      return InPenddingDemandState(pending, accepted);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return currentState;
    }
  }
}