import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InboxItem extends StatefulWidget {
  final Demand demand;

  InboxItem({@required this.demand}) : assert(demand != null);

  @override
  _InboxItemState createState() => _InboxItemState();
}

class _InboxItemState extends State<InboxItem> {
  bool details;

  @override
  void initState() {
    // TODO: implement initState
    details = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    switch (widget.demand.state) {
      case DemandType.PENDING:
      case DemandType.SENDED:
        return newInboxItem(width);
        break;
      case DemandType.ACCEPTED:
        return acceptedInboxItem(width);
        break;
      case DemandType.IN_COURSE:
        return inProgressInboxItem(width);
      case DemandType.ASSIGNED:
        return assignedInboxItem(width);
        break;
    }
    return Container();
  }

  Widget newInboxItem(double width) {
    return Card(
        elevation: 1,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.65),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  widget.demand.getState(),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  DateFormat("dd 'de' MMMM 'del' yyyy", "es_ES")
                                      .format(
                                          DateTime.parse(widget.demand.date))
                                      .toString()
                                      .toUpperCase(),
                                  // "08 DE DICIEMBRE DEL 2017",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.alarm,
                                    size: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      DateFormat("hh:mm a", "es_ES")
                                          .format(DateTime.parse(
                                              widget.demand.date))
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.55),
                                  child: Text(
                                    widget.demand.client.fullname,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  OutlineButton(
                    child: details ? Text("VER MENOS") : Text("DETALLES"),
                    onPressed: () {
                      setState(() {
                        details = !details;
                      });
                    },
                  )
                ],
              ),
              details
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    widget.demand.client.phone,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.trip_origin,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "DESDE",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                widget.demand.originAddress.addressText,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "HASTA",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                widget.demand.destinationAddress.addressText,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Container(
                                width: (width - 50) / 2,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "DESDE",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: (width - 60) / 2,
                                          ),
                                          child: Text(
                                            widget.demand.originAddress
                                                .addressText,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Container(
                                width: (width - 60) / 2,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "HASTA",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: (width - 60) / 2,
                                          ),
                                          child: Text(
                                            widget.demand.destinationAddress
                                                .addressText,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                        onPressed: () {},
                        child: Text(
                          "DECLINAR",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Expanded(
                    child: OutlineButton(
                        onPressed: () {
                          DemandsBloc()
                              .dispatch(AcceptDemandEvent(widget.demand.id));
                        },
                        child: Text(
                          "ACEPTAR",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget acceptedInboxItem(double width) {
    return Card(
        elevation: 1,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.65),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  widget.demand.getState(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  DateFormat("dd 'de' MMMM 'del' yyyy", "es_ES")
                                      .format(
                                          DateTime.parse(widget.demand.date))
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.alarm,
                                    size: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      DateFormat("hh:mm a", "es_ES")
                                          .format(DateTime.parse(
                                              widget.demand.date))
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.55),
                                  child: Text(
                                    widget.demand.client.fullname,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  OutlineButton(
                    child: details ? Text("VER MENOS") : Text("DETALLES"),
                    onPressed: () {
                      setState(() {
                        details = !details;
                      });
                    },
                  )
                ],
              ),
              details
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    widget.demand.client.phone,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.trip_origin,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "DESDE",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                widget.demand.originAddress.addressText,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "HASTA",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                widget.demand.destinationAddress.addressText,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    widget.demand.client.phone,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "HASTA",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                widget.demand.destinationAddress.addressText,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                        onPressed: () {
                          // Cancel
                        },
                        child: Text(
                          "CANCELAR",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget inProgressInboxItem(double width) {
    return Card(
        elevation: 1,
        color: Theme.of(context).primaryColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.65),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.local_taxi,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      "EN CURSO",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "08 DE DICIEMBRE DEL 2017",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.alarm,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      "03:00 PM",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.55),
                                  child: Text(
                                    "Eduardo Mustelier Martínez",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  OutlineButton(
                    borderSide: BorderSide(color: Colors.white),
                    child: details
                        ? Text(
                            "VER MENOS",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        : Text("DETALLES",
                            style: TextStyle(
                              color: Colors.white,
                            )),
                    onPressed: () {
                      setState(() {
                        details = !details;
                      });
                    },
                  )
                ],
              ),
              details
                  ? Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "53 307651",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.trip_origin,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "DESDE",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                "Manuel Ascunce 201, entre Luis Hidalgo y Mariano Rajoy, 10 de octubre",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "HASTA",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                "Manuel Ascunce 201, entre Luis Hidalgo y Mariano Rajoy, 10 de octubre",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "53 307651",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "HASTA",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                "Manuel Ascunce 201, entre Luis Hidalgo y Mariano Rajoy, 10 de octubre",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                        borderSide: BorderSide(color: Colors.white),
                        onPressed: () {},
                        child: Text(
                          "DECLINAR",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget assignedInboxItem(double width) {
    return Card(
        elevation: 1,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.65),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "ASIGNADO",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "08 DE DICIEMBRE DEL 2017",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.alarm,
                                    size: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      "03:00 PM",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              )),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.55),
                                  child: Text(
                                    "Eduardo Mustelier Martínez",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  OutlineButton(
                    child: details ? Text("VER MENOS") : Text("DETALLES"),
                    onPressed: () {
                      setState(() {
                        details = !details;
                      });
                    },
                  )
                ],
              ),
              details
                  ? Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "53 307651",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.trip_origin,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "DESDE",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                "Manuel Ascunce 201, entre Luis Hidalgo y Mariano Rajoy, 10 de octubre",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    "HASTA",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.85),
                              child: Text(
                                "Manuel Ascunce 201, entre Luis Hidalgo y Mariano Rajoy, 10 de octubre",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Container(
                                width: (width - 50) / 2,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "DESDE",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: (width - 60) / 2,
                                          ),
                                          child: Text(
                                            "10 Octubre",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Container(
                                width: (width - 60) / 2,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "HASTA",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: (width - 60) / 2,
                                          ),
                                          child: Text(
                                            "10 Octubre",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                        onPressed: () {},
                        child: Text(
                          "DECLINAR",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Expanded(
                    child: OutlineButton(
                        onPressed: () {},
                        child: Text(
                          "ACEPTAR",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
