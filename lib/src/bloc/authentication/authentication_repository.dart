import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';

import 'authentication_provider.dart';
import 'index.dart';

class AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider =
      new AuthenticationProvider();

  AuthenticationRepository();

  Future<ResponseModel<AuthenticationModel>> login(
      String username, String password) {
    return _authenticationProvider.findAll("""
        query login(\$usernameOrEmail: String!, \$password: String!) {
          login(usernameOrEmail: \$usernameOrEmail, password: \$password) {
          token
            username
            fullname
            email
            role {
                name
            }
            id
            phone
            profileImageId
            driver{
              id
              name
              score
              userId
              phone
            }
          }
        }
         """, data: {"usernameOrEmail": username, "password": password});
  }
}
