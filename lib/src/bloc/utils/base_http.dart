import 'package:graphql/client.dart';

class BaseHttpConfig {
  factory BaseHttpConfig() {
    return _baseHttpConfig;
  }

  GraphQLClient _clientGraph;

  static final BaseHttpConfig _baseHttpConfig = new BaseHttpConfig._internal();

  BaseHttpConfig._internal() {
    _clientGraph = new GraphQLClient(
        link: HttpLink(uri: "http://10.0.0.131/api/graphql"),
        cache: NormalizedInMemoryCache(
            dataIdFromObject: typenameDataIdFromObject));
  }

  GraphQLClient get graphClient => _clientGraph;
}

mixin DioBase {
  final _baseHttpConfig = new BaseHttpConfig();

  GraphQLClient get client => _baseHttpConfig.graphClient;
}
