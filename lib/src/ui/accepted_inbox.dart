import 'package:flutter/material.dart';

import 'inbox.dart';
import 'inbox_item.dart';

class AcceptedInbox extends StatefulWidget {
  @override
  _AcceptedInboxState createState() => _AcceptedInboxState();
}

class _AcceptedInboxState extends State<AcceptedInbox> {
  List<InboxItem> items;

  @override
  void initState() {
    items = <InboxItem>[
//      InboxItem(status: InboxStatus.ACCEPTED),
//      InboxItem(status: InboxStatus.IN_PROGRESS),
//      InboxItem(status: InboxStatus.IN_PROGRESS),
//      InboxItem(status: InboxStatus.ACCEPTED),
//      InboxItem(status: InboxStatus.ACCEPTED),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Inbox(items: items);
  }
}
