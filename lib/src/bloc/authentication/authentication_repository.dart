import 'package:dtaxi_driver/src/bloc/utils/graphql_queries.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';

import 'authentication_provider.dart';
import 'index.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider =
      new AuthenticationProvider();

  AuthenticationRepository();

  Future<ResponseModel<AuthenticationModel>> login(
      String username, String password) {
    return _authenticationProvider.query(Queries.login, "login",
        data: {"usernameOrEmail": username, "password": password});
  }
}
