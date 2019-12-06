import 'package:dtaxi_driver/src/bloc/demands/demands_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SDemandState extends Equatable {
  SDemandState([Iterable props]) : super(props);

  /// Copy object for use in action
  SDemandState copyWith();
}

/// UnInitialized
class UnSDemandState extends SDemandState {
  @override
  String toString() => 'UnSDemandState';

  @override
  SDemandState copyWith() {
    return UnSDemandState();
  }
}

/// Initialized
class InPenddingDemandState extends SDemandState {
  final List<Demand> pending;
  final List<Demand> accepted;
  final String error;

  InPenddingDemandState(this.pending,this.accepted, {this.error}) : super([pending,accepted, error]);
  @override
  String toString() => 'InSDemandState';

  @override
  SDemandState copyWith() {
    return InPenddingDemandState(pending,accepted,error: error);
  }
}

//InAcceptedDemands
class InAcceptedDemands extends SDemandState {
  final List<Demand> demands;
  final String error;

  InAcceptedDemands(this.demands, {this.error}) : super([demands, error]);
  @override
  String toString() => 'InSDemandState';

  @override
  SDemandState copyWith() {
    return InAcceptedDemands(demands,error: error);
  }
}

/// On Error
class ErrorSDemandState extends SDemandState {
  final String user;
  final String errorMessage;

  ErrorSDemandState(this.errorMessage,{this.user});

  @override
  String toString() => 'ErrorNewsState';

  @override
  SDemandState copyWith() {
    return ErrorSDemandState(this.errorMessage,user:this.user);
  }
}

