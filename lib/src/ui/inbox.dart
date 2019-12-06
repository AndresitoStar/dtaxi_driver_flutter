import 'package:dtaxi_driver/src/bloc/demands/demands_model.dart';
import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/common/app_drawer.dart';
import 'package:dtaxi_driver/src/common/app_scaffold.dart';
import 'package:flutter/material.dart';

import 'inbox_item.dart';

class Inbox extends StatefulWidget {
  final List<Demand> inboxItems;
  final List<Demand> acceptedItems;
  final DemandsBloc demandsBloc;

  Inbox({this.inboxItems, this.acceptedItems, this.demandsBloc});

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> with SingleTickerProviderStateMixin {
  TabController _controller;
  List<_TabContent> _allPages;
  createPages() {
    _allPages = <_TabContent>[
      _TabContent(text: "Pendientes", child: widget.inboxItems),
      _TabContent(text: "Aceptados", child: widget.acceptedItems)
    ];
  }

  @override
  void initState() {
    createPages();
    _controller = TabController(vsync: this, length: _allPages.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titleChild: Text("Bandeja de entrada"),
      appDrawer: AppDrawer(),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Container(
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            controller: _controller,
            isScrollable: false,
            tabs: _allPages.map<Container>((_TabContent page) {
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
          children: _allPages.map<Widget>((_TabContent page) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Container(
                padding: const EdgeInsets.all(0.0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ListView.builder(
                    itemCount: page.child.length,
                    itemBuilder: (context, index) {
                      return InboxItem(
                        demand: page.child[index],
                        demandsBloc: widget.demandsBloc,
                      );
                    },
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}

class _TabContent {
  const _TabContent({this.text, @required this.child});

  final String text;
  final List<Demand> child;
}
