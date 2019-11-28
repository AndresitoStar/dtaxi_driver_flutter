import 'package:graphql_flutter/graphql_flutter.dart';

import 'base_http.dart';
import 'response_model.dart';

typedef CreateModelFromJson = dynamic Function(Map<String, dynamic> json);
typedef CreateJsonFromModel<T> = Map<String, dynamic> Function(T model);

class IProvider<T> with DioBase {
  IProvider(this.endpoint,
      {this.createModelFromJson,
      this.createJsonFromModel,
      this.createResponseModelFromJson});

  CreateJsonFromModel<T> createJsonFromModel;
  CreateModelFromJson createModelFromJson;
  CreateModelFromJson createResponseModelFromJson;
  final endpoint;

  Future<ResponseModel<T>> findAll(String query,
      {Map<String, dynamic> data}) async {
    var response =
        await client.query(QueryOptions(document: query, variables: data));
    return createResponseModelFromJson(response.data);
  }
}
