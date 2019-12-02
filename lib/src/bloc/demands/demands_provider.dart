import 'package:dtaxi_driver/src/bloc/utils/provider_interface.dart';

import 'demands_model.dart';

class DemandsProvider extends IProvider<Demand> {
  DemandsProvider()
      : super(
          createModelFromJson: (json, key) =>
              DemandsResponse.fromJson(json, key).results,
          createResponseModelFromJson: (json, key) =>
              DemandsResponse.fromJson(json, key),
          createJsonFromModel: (Demand model) => model.toJson(),
        );
}
