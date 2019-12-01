import 'package:dtaxi_driver/src/bloc/utils/provider_interface.dart';

import 'demands_model.dart';

class DemandsProvider extends IProvider<Demand> {
  DemandsProvider()
      : super(
          createModelFromJson: (json) => DemandsResponse.fromJson(json).results,
          createResponseModelFromJson: (json) => DemandsResponse.fromJson(json),
          createJsonFromModel: (Demand model) => model.toJson(),
        );
}
