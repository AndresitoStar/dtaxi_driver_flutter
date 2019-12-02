import 'package:graphql_flutter/graphql_flutter.dart';

import 'base_http.dart';
import 'response_model.dart';

typedef CreateModelFromJson = dynamic Function(Map<String, dynamic> json);
typedef CreateJsonFromModel<T> = Map<String, dynamic> Function(T model);

class IProvider<T> with DioBase {
  IProvider(
      {this.createModelFromJson,
      this.createJsonFromModel,
      this.createResponseModelFromJson});

  CreateJsonFromModel<T> createJsonFromModel;
  CreateModelFromJson createModelFromJson;
  CreateModelFromJson createResponseModelFromJson;

  Future<ResponseModel<T>> query(String query,
      {Map<String, dynamic> data}) async {
    var response = await client.query(QueryOptions(
      document: query,
      variables: data,
    ));
    return createResponseModelFromJson(response.data);
  }

  Future<ResponseModel<T>> mutate(String mutation,
      {Map<String, dynamic> data}) async {
    var response = await client.mutate(MutationOptions(
      document: mutation,
      variables: data,
    ));
    return createResponseModelFromJson(response.data);
  }
}
