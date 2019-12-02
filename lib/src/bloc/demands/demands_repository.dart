import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/bloc/utils/graphql_queries.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';

class DemandsRepository {
  final DemandsProvider _demandsProvider = new DemandsProvider();

  DemandsRepository();

  Future<ResponseModel<Demand>> loadPendingDemands(
      {List<String> demandStates}) async {
    return await _demandsProvider.query(Queries.demandsList, data: {
      "states": demandStates ??
          [
            DemandType.SENDED,
            DemandType.PENDING,
          ]
    });
  }

  Future<ResponseModel<Demand>> loadDemandsByDriver(
      {List<String> demandStates}) async {
    return await _demandsProvider.query(Queries.demandsByDriver, data: {
      "states": demandStates ??
          [
            DemandType.ACCEPTED,
            DemandType.ASSIGNED,
            DemandType.IN_COURSE,
          ]
    });
  }

  Future<ResponseModel<Demand>> acceptDemand(String demandId) async {
    return await _demandsProvider
        .mutate(Mutations.acceptDemand, data: {"demandId": demandId});
  }

  Future<ResponseModel<Demand>> cancelDemand(String demandId) async {
    return await _demandsProvider
        .mutate(Mutations.cancelDemand, data: {"demandId": demandId});
  }
}
