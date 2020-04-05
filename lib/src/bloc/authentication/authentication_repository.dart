import 'package:dtaxi_driver/src/bloc/utils/graphql_queries.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';
import 'package:dtaxi_driver/src/bloc/utils/secure_storage.dart';
import 'package:geolocator/geolocator.dart';

import 'authentication_provider.dart';
import 'index.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider =
      new AuthenticationProvider();

  final DriverProvider _driverProvider = new DriverProvider();

  AuthenticationRepository();

  Future<ResponseModel<AuthenticationModel>> login(
      String username, String password) {
    return _authenticationProvider.query(Queries.login, "login",
        data: {"usernameOrEmail": username, "password": password});
  }

  Future<ResponseModel<Driver>> updateDriverState(String driverId, String state, {Position location}) async {
    Map resource = {
      "state": state
    };
    if(location != null){
      resource.addAll({
        "latitude": location.latitude,
        "longitude" : location.longitude
      });
    }

    var data = await _driverProvider.mutate(Mutations.updateDriver, "driverUpdateV2",
      data: {"id": driverId, "resource": resource}
    );

    if (data.results.first != null) {
      await SecureStorage.saveDriverData(data.results.first);
    }

    return data;
  }
}
