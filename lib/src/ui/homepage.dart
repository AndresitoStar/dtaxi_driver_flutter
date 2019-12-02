import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/common/app_drawer.dart';
import 'package:dtaxi_driver/src/common/app_scaffold.dart';
import 'package:flutter/material.dart';

enum HomepageTab { INBOX, ACCEPTED }

class _Page {
  const _Page({this.text, @required this.child});

  final String text;
  final Widget child;
}

class Homepage extends StatefulWidget {
  Homepage({Key key, this.title, this.tab}) : super(key: key);

  final String title;
  final HomepageTab tab;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  final List<_Page> _allPages = <_Page>[
    _Page(
        text: "Todos",
        child: DemandsScreen(
          demandsBloc: DemandsBloc(),
        )),
    _Page(
        text: "Aceptados",
        child: DemandsScreen(
          demandsBloc: DemandsBloc(),
          demandsByDriver: true,
        ))
  ];

  @override
  void initState() {
    _controller = TabController(vsync: this, length: _allPages.length);
    if (widget.tab != null) {
      switch (widget.tab) {
        case HomepageTab.INBOX:
          _controller.animateTo(0);
          break;
        case HomepageTab.ACCEPTED:
          _controller.animateTo(1);
          break;
        default:
          break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titleChild: Text(widget.title),
      appDrawer: AppDrawer(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Container(
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            controller: _controller,
            isScrollable: false,
            tabs: _allPages.map<Container>((_Page page) {
              return Container(
                height: 40.0,
                child: Tab(child: Text(page.text)),
              );
            }).toList(),
          ),
        ),
      ),
      child: TabBarView(
          controller: _controller,
          children: _allPages.map<Widget>((_Page page) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Container(
                padding: const EdgeInsets.all(0.0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(child: page.child),
                ),
              ),
            );
          }).toList()),
    );
  }
}
