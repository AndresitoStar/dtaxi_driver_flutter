import 'package:dtaxi_driver/src/bloc/utils/provider_interface.dart';

import 'index.dart';

class AuthenticationProvider extends IProvider<AuthenticationModel> {
  AuthenticationProvider()
      : super(
          createModelFromJson: (json, key) =>
              AuthenticationResponse.fromJson(json, key).results,
          createResponseModelFromJson: (json, key) =>
              AuthenticationResponse.fromJson(json, key),
          createJsonFromModel: (AuthenticationModel model) => model.toJson(),
        );
}
