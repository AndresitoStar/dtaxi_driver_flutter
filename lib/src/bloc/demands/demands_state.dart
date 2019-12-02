import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:equatable/equatable.dart';
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
  final List<Demand> demands;
  final String error;

  InDemandsState(this.demands, {this.error}) : super([demands, error]);

  @override
  String toString() => 'InDemandsState';

  @override
  DemandsState copyWith({List<Demand> demands, String error}) {
    return InDemandsState(demands ?? this.demands, error: error ?? this.error);
  }
}

class ErrorDemandsState extends DemandsState {
  final String errorMessage;

  ErrorDemandsState(this.errorMessage);

  @override
  String toString() => 'ErrorDemandsState';

  @override
  DemandsState copyWith() {
    return ErrorDemandsState(this.errorMessage);
  }
}

class ErrorDemandOnDialogState extends DemandsState {
  final String errorMessage;

  ErrorDemandOnDialogState(this.errorMessage);

  @override
  String toString() => 'ErrorDemandOnDialogState';

  @override
  DemandsState copyWith() {
    return ErrorDemandOnDialogState(this.errorMessage);
  }
}
