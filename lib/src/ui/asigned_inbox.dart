import 'package:flutter/material.dart';

import 'inbox.dart';
import 'inbox_item.dart';

class AssignedInbox extends StatefulWidget {
  @override
  _AssignedInboxState createState() => _AssignedInboxState();
}

class _AssignedInboxState extends State<AssignedInbox> {
  List<InboxItem> items;

  @override
  void initState() {
    items = <InboxItem>[
      InboxItem(status: InboxStatus.ASSIGNED),
      InboxItem(status: InboxStatus.ASSIGNED),
      InboxItem(status: InboxStatus.IN_PROGRESS),
      InboxItem(status: InboxStatus.ASSIGNED),
      InboxItem(status: InboxStatus.IN_PROGRESS),
      InboxItem(status: InboxStatus.ACCEPTED),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Inbox(items: items);
  }
}
