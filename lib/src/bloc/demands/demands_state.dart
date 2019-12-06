import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DemandsState extends Equatable {
  DemandsState([Iterable props]) : super(props);

  /// Copy object for use in action
  DemandsState copyWith();
}

/// UnInitialized
class UnDemandsState extends DemandsState {
  @override
  String toString() => 'UnDemandsState';

  @override
  DemandsState copyWith() {
    return UnDemandsState();
  }
}

/// Initialized
class InDemandsState extends DemandsState {
  final List<Demand> pendingDemands;
  final List<Demand> acceptedDemands;
  final String error;

  InDemandsState(this.pendingDemands, this.acceptedDemands, {this.error})
      : super([pendingDemands, acceptedDemands, error]);

  @override
  String toString() => 'InDemandsState';

  @override
  DemandsState copyWith({error}) {
    return InDemandsState(pendingDemands, acceptedDemands, error: error);
  }
}

class ErrorDemandsState extends DemandsState {
  final String errorMessage;

  ErrorDemandsState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorDemandsState';

  @override
  DemandsState copyWith() {
    return ErrorDemandsState(this.errorMessage);
  }
}

class ErrorDemandOnDialogState extends DemandsState {
  final String errorMessage;

  ErrorDemandOnDialogState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorDemandOnDialogState';

  @override
  DemandsState copyWith() {
    return ErrorDemandOnDialogState(this.errorMessage);
  }
}
