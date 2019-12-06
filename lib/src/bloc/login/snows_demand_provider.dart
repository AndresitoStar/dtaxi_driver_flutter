import 'package:dio/dio.dart';
import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/bloc/utils/db/dbhelper.dart';

import 'index.dart';

class DemandProvider {
  Future<List<Demand>> findDemand(String url) async {
    DBHelper<Demand> _dbHelper = DBHelper<Demand>(
        dbTableName: 'demand', tableField: Demand.getFieldsForDB());
    List<Demand> pendings=<Demand>[];
    var dio = Dio();
    var result = await dio.get(url);
    var data = result.data['data'];
    for (int i = 0; i < data.length; i++) {
      var element=Demand.fromDBJson(data[i]);
      pendings.add(Demand.fromDBJson(data[i]));
      var lolo=element.toDBJson();
      _dbHelper.saveOne(lolo);
    }
    return pendings;
  }
}
