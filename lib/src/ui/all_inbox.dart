import 'package:flutter/material.dart';

import 'inbox.dart';
import 'inbox_item.dart';

class AllInbox extends StatefulWidget {
  @override
  _AllInboxState createState() => _AllInboxState();
}

class _AllInboxState extends State<AllInbox> {
  List<InboxItem> items;

  @override
  void initState() {
    items = <InboxItem>[
      InboxItem(status: InboxStatus.SENT),
      InboxItem(status: InboxStatus.ACCEPTED),
      InboxItem(status: InboxStatus.IN_PROGRESS),
      InboxItem(status: InboxStatus.ASSIGNED),
      InboxItem(status: InboxStatus.ACCEPTED),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Inbox(items: items);
  }
}
