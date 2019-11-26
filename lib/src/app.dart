import 'package:dtaxi_driver/src/common/theme_data.dart';
import 'package:dtaxi_driver/src/ui/splash.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: dtaxiThemeData,
      //home: Homepage(title: 'Flutter Demo Home Page', tab: HomepageTab.INBOX),
      home: Splash(),
    );
  }
}
