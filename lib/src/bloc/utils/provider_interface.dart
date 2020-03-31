import 'package:graphql_flutter/graphql_flutter.dart';

import 'base_http.dart';
import 'response_model.dart';

typedef CreateModelFromJson = dynamic Function(
    Map<String, dynamic> json, String key);
typedef CreateJsonFromModel<T> = Map<String, dynamic> Function(T model);

class IProvider<T> with DioBase {
  IProvider(
      {this.createModelFromJson,
      this.createJsonFromModel,
      this.createResponseModelFromJson});

  CreateJsonFromModel<T> createJsonFromModel;
  CreateModelFromJson createModelFromJson;
  CreateModelFromJson createResponseModelFromJson;

  Future<ResponseModel<T>> query(String query, String key,
      {Map<String, dynamic> data}) async {
    var response = await client.query(QueryOptions(
      document: query,
      variables: data,
    ));
    if(response.hasException) {
      if (response.exception.graphqlErrors.isNotEmpty)
        throw new Exception(response.exception.graphqlErrors.first.message);
      if (response.exception.clientException != null){
        throw new Exception(response.exception.clientException.message);
      }
    }
    return createResponseModelFromJson(response.data, key);
  }

  Future<ResponseModel<T>> mutate(String mutation, String key,
      {Map<String, dynamic> data}) async {
    var response = await client.mutate(MutationOptions(
      document: mutation,
      variables: data,
    ));

    if(response.hasException) {
      if (response.exception.graphqlErrors.isNotEmpty)
        throw new Exception(response.exception.graphqlErrors.first.message);
      if (response.exception.clientException != null){
        throw new Exception(response.exception.clientException.message);
      }
    }
    return createResponseModelFromJson(response.data, key);
  }

  Stream<ResponseModel<T>> subscribe(String subscription, String key,
      {Map<String, dynamic> data}) async* {
    //client.subscribe(Opera(subscription)).map(convert);
  }
}
