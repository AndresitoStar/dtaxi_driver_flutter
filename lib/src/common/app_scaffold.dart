import 'package:dtaxi_driver/src/common/app_drawer.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final AppDrawer appDrawer;
  final Widget child;
  final PreferredSizeWidget bottom;
  final List<Widget> actions;
  final Widget titleChild;
  final Widget floatingActionButton;

  const AppScaffold({
    Key key,
    this.appDrawer,
    @required this.child,
    this.bottom,
    this.actions,
    this.titleChild,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      floatingActionButton: this.widget.floatingActionButton,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: this.widget.titleChild,
          centerTitle: true,
          bottom: this.widget.bottom,
          actions: this.widget.actions),
      drawer: this.widget.appDrawer,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(child: this.widget.child),
      ),
    );
  }
}
