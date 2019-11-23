import 'package:flutter/material.dart';

import 'inbox_item.dart';

class Inbox extends StatefulWidget {
  final List<InboxItem> items;

  Inbox({this.items});

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.6),
      child: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, item) {
          return widget.items[item];
        },
      ),
    );
  }
}
