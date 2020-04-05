import 'package:dtaxi_driver/src/bloc/utils/graphql_queries.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';
import 'package:dtaxi_driver/src/bloc/utils/secure_storage.dart';

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

  Future<ResponseModel<Driver>> updateDriverState(String driverId, String state) async {
    var data = await _driverProvider.mutate(Mutations.updateDriver, "driverUpdateV2",
      data: {"id": driverId, "resource": {"state": state}}
    );

    if (data.results.first != null) {
      SecureStorage.saveDriverData(data.results.first);
    }

    return data;
  }
}
