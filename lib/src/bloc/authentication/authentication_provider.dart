import 'package:dtaxi_driver/src/bloc/utils/provider_interface.dart';

import 'index.dart';

class AuthenticationProvider extends IProvider<AuthenticationModel> {
  AuthenticationProvider()
      : super(
          createModelFromJson: (json) =>
              AuthenticationResponse.fromJson(json).results,
          createResponseModelFromJson: (json) =>
              AuthenticationResponse.fromJson(json),
          createJsonFromModel: (AuthenticationModel model) => model.toJson(),
        );
}
