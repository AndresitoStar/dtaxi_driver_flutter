import 'package:dtaxi_driver/src/common/app_drawer.dart';
import 'package:dtaxi_driver/src/common/app_scaffold.dart';
import 'package:flutter/material.dart';

class LostAndFound extends StatefulWidget {
  @override
  _LostAndFoundState createState() => _LostAndFoundState();
}

class _LostAndFoundState extends State<LostAndFound> {
  List<LostAndFoundItem> items;

  @override
  void initState() {
    items = <LostAndFoundItem>[
      LostAndFoundItem(),
      LostAndFoundItem(),
      LostAndFoundItem(),
      LostAndFoundItem(),
      LostAndFoundItem()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        titleChild: Text("Objetos perdidos"),
        appDrawer: AppDrawer(),
        child: Container(
          color: Colors.grey.withOpacity(0.6),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, item) {
              return items[item];
            },
          ),
        ));
  }
}

class LostAndFoundItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Container(
            constraints: BoxConstraints(minHeight: 75),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "CLIENTE NÚMERO 3",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text("Se me perdió la carteras",
                                            style: TextStyle(fontSize: 19))))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("22 de octubre del 2018",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400)))
                              ],
                            )
                          ],
                        ))),
                Expanded(
                    flex: 1,
                    child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 6,
                        child: FlatButton(
                            color: Colors.green,
                            onPressed: () {},
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 35,
                            )))),
              ],
            )));
  }
}
