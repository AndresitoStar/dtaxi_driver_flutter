import 'package:dtaxi_driver/src/common/app_drawer.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget title;
  final Widget body;

  const AppScaffold({Key key, this.title, this.body})
      : assert(body != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      drawer: AppDrawer(),
      body: body,
    );
  }
}
