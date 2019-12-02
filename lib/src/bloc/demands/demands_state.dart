import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/bloc/utils/list_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

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
  final List<Demand> demands;
  final String error;

  InDemandsState(this.demands, {this.error}) : super([demands, error]);

  @override
  String toString() => 'InDemandsState';

  @override
  DemandsState copyWith({List<Demand> demands, String error}) {
    return InDemandsState(demands ?? this.demands, error: error);
  }

  @override
  bool operator ==(Object other) {
    return other is InDemandsState &&
        this.error == other.error &&
        ListUtils.listCompare(this.demands, other.demands);
  }

  @override
  int get hashCode {
    return hashObjects([
      this.demands,
      this.error,
    ].where((s) => s != null));
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
