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

  InDemandsState(this.demands) : super([demands]);

  @override
  String toString() => 'InDemandsState';

  @override
  DemandsState copyWith({List<Demand> demands}) {
    return InDemandsState(demands ?? this.demands);
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
