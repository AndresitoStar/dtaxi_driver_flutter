import 'package:dtaxi_driver/src/common/theme_data.dart';
import 'package:flutter/material.dart';

import 'bloc/authentication/authentication_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dtaxi Driver',
      theme: dtaxiThemeData,
      //home: Homepage(title: 'Flutter Demo Home Page', tab: HomepageTab.INBOX),
      home: AuthenticationPage(),
    );
  }
}
