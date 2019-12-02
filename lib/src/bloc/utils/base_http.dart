import 'package:dtaxi_driver/src/bloc/utils/secure_storage.dart';
import 'package:graphql/client.dart';

class BaseHttpConfig {
  factory BaseHttpConfig() {
    return _baseHttpConfig;
  }

  GraphQLClient _clientGraph;

  static final BaseHttpConfig _baseHttpConfig = new BaseHttpConfig._internal();

  BaseHttpConfig._internal() {
    final HttpLink _httpLink =
        HttpLink(uri: "http://dtaxi.pyxel.cu/api/graphql");
    final AuthLink _authLink =
        AuthLink(getToken: () async => await SecureStorage.getToken());

    final Link _link = _authLink.concat(_httpLink);

    _clientGraph = new GraphQLClient(link: _link, cache: InMemoryCache());
  }

  GraphQLClient get graphClient => _clientGraph;
}

mixin DioBase {
  final _baseHttpConfig = new BaseHttpConfig();

  GraphQLClient get client => _baseHttpConfig.graphClient;
}
