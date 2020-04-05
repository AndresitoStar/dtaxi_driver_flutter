import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/bloc/utils/db/dbhelper.dart';
import 'package:dtaxi_driver/src/bloc/utils/graphql_queries.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';

class DemandsRepository {
  final DemandsProvider _demandsProvider = new DemandsProvider();
  final DBHelper<Demand> _helper = new DBHelper(dbTableName: 'demand');

  DemandsRepository(){
    _helper.initDb();
  }

  Future<List<Demand>> loadPendingDemands(
      {List<String> demandStates, bool api = false}) async {

    if(api){
      var apiResponse = await _demandsProvider
          .query(Queries.demandsList, "demandsByStatesV2", data: {
        "states": demandStates ??
            [
              DemandType.SENT,
              DemandType.PENDING,
            ]
      });

      await saveDemands(apiResponse.results);
     }

    List<Map<String, dynamic>> dbresponse = await _helper.findAll(where: {
      "state" : [
        DemandType.SENT,
        DemandType.PENDING,
      ]
    });

    return dbresponse.map((dbJson)=> Demand.fromDBJson(dbJson)).toList();
  }

  Future<List<Demand>> loadDemandsByDriver(
      {List<String> demandStates, bool api = false}) async {

    if(api){
      var apiResponse = await _demandsProvider
          .query(Queries.demandsByDriver, "demandsByStatesWithoutDate", data: {
        "states": demandStates ??
            [
              DemandType.ACCEPTED,
              DemandType.ASSIGNED,
              DemandType.STARTED,
              DemandType.IN_COURSE,
            ]
      });

      await saveDemands(apiResponse.results);
    }

    List<Map<String, dynamic>> dbresponse = await _helper.findAll(where: {
      "state" : [
        DemandType.ACCEPTED,
        DemandType.ASSIGNED,
        DemandType.STARTED,
        DemandType.IN_COURSE,
      ]
    });

    return dbresponse.map((dbJson)=> Demand.fromDBJson(dbJson)).toList();
  }

  Future<ResponseModel<Demand>> acceptDemand(String demandId) async {
    var response =  await _demandsProvider.mutate(
        Mutations.acceptDemand, "demandAccepted",
        data: {"demandId": demandId});

    if(response.results.length > 0){
      _helper.saveOne(response.results[0].toDBJson());
    }

    return response;
  }

  Future<ResponseModel<Demand>> cancelDemand(String demandId, String cancelType,
      {String reason}) async {
    var response =   await _demandsProvider
        .mutate(Mutations.cancelDemand, "cancelDemandByDriver", data: {
      "demandId": demandId,
      "canceledType": cancelType,
      if (reason != null) "reason": reason
    });

    _helper.delete(stringId: demandId);

    return response;
  }

  Future<ResponseModel<Demand>> startDemand(String demandId) async {
    var response =   await _demandsProvider
        .mutate(Mutations.startDemand, "demandStarted", data: {
      "demandId": demandId,
    });

    if(response.results.length > 0){
      _helper.saveOne(response.results[0].toDBJson());
    }

    return response;
  }

  Future<ResponseModel<Demand>> declineDemand(String demandId) async {
    var response =   await _demandsProvider
        .mutate(Mutations.declineDemand, "demandNotifyAction", data: {
      "demandId": demandId,
    });

    _helper.delete(stringId: demandId);

    return response;
  }

  Future<ResponseModel<Demand>> pickUpClient(String demandId) async {
    var response =   await _demandsProvider
        .mutate(Mutations.pickUpClient, "demandInCourse", data: {
      "demandId": demandId,
    });

    if(response.results.length > 0){
      _helper.saveOne(response.results[0].toDBJson());
    }

    return response;
  }

  Future<ResponseModel<Demand>> finishDemand(String demandId) async {
    var response =   await _demandsProvider
        .mutate(Mutations.finishDemand, "demandFinished", data: {
      "demandId": demandId,
    });

    if(response.results.length > 0){
      _helper.saveOne(response.results[0].toDBJson());
    }

    return response;
  }

  Future<void> saveDemands(List<Demand> demands) async {
    return await _helper.saveAll(demands.map((demand)=>demand.toDBJson()).toList());
  }
}
