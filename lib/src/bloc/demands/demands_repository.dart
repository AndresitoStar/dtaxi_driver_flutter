import 'dart:developer';

import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/bloc/utils/graphql_queries.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';

class DemandsRepository {
  final DemandsProvider _demandsProvider = new DemandsProvider();

  DemandsRepository();

  Future<ResponseModel<Demand>> loadPendingDemands(
      {List<String> demandStates}) async {
    return await _demandsProvider
        .query(Queries.demandsList, "demandsByStatesV2", data: {
      "states": demandStates ??
          [
            DemandType.SENT,
            DemandType.PENDING,
          ]
    });
  }

  Future<ResponseModel<Demand>> loadDemandsByDriver(
      {List<String> demandStates}) async {
    return await _demandsProvider
        .query(Queries.demandsByDriver, "demandsByStatesWithoutDate", data: {
      "states": demandStates ??
          [
            DemandType.ACCEPTED,
            DemandType.ASSIGNED,
            DemandType.IN_COURSE,
          ]
    });
  }

  Future<ResponseModel<Demand>> acceptDemand(String demandId) async {
    return await _demandsProvider.mutate(
        Mutations.acceptDemand, "demandAccepted",
        data: {"demandId": demandId});
  }

  Future<ResponseModel<Demand>> cancelDemand(String demandId, String cancelType,
      {String reason}) async {
    return await _demandsProvider
        .mutate(Mutations.cancelDemand, "cancelDemandByDriver", data: {
      "demandId": demandId,
      "canceledType": cancelType,
      if (reason != null) "reason": reason
    });
  }

  Future<ResponseModel<Demand>> startDemand(String demandId) async {
    return await _demandsProvider
        .mutate(Mutations.startDemand, "demandStarted", data: {
      "demandId": demandId,
    });
  }

  Future<ResponseModel<Demand>> declineDemand(String demandId) async {
    return await _demandsProvider
        .mutate(Mutations.declineDemand, "demandNotifyAction", data: {
      "demandId": demandId,
    });
  }

  Future<ResponseModel<Demand>> pickUpClient(String demandId) async {
    return await _demandsProvider
        .mutate(Mutations.pickUpClient, "demandInCourse", data: {
      "demandId": demandId,
    });
  }

  Future<ResponseModel<Demand>> finishDemand(String demandId) async {
    return await _demandsProvider
        .mutate(Mutations.finishDemand, "demandFinished", data: {
      "demandId": demandId,
    });
  }
}
