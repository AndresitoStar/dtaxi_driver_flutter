import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InboxItem extends StatefulWidget {
  final Demand demand;
  final DemandsBloc demandsBloc;

  InboxItem({@required this.demand, this.demandsBloc}) : assert(demand != null);

  @override
  _InboxItemState createState() => _InboxItemState();
}

class _InboxItemState extends State<InboxItem> {
  bool details;
//  String _radioReasonValue = "";

  bool loading;

  @override
  void initState() {
    details = true;
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    switch (widget.demand.state) {
      case DemandType.PENDING:
        return newInboxItem(width);
      case DemandType.SENT:
        return newInboxItem(width);
        break;
      case DemandType.ACCEPTED:
        return acceptedInboxItem(width, accepted: true);
        break;
      case DemandType.IN_COURSE:
        return inProgressInboxItem(width);
      case DemandType.ASSIGNED:
        return acceptedInboxItem(width, accepted: false);
        break;
      case DemandType.STARTED:
        return startedInboxItem(width);
        break;
    }
    return Container();
  }

  Widget newInboxItem(double width) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        elevation: 3,
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
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
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: details ? Text("DETALLES") : Text("VER MENOS"),
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
                        onPressed: () {
                          widget.demandsBloc
                              .add(AcceptDemandEvent(widget.demand.id));
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

  Widget acceptedInboxItem(double width, {bool accepted}) {
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
                                    .format(DateTime.parse(widget.demand.date))
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 14),
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
                                        .format(
                                            DateTime.parse(widget.demand.date))
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
                  padding: const EdgeInsets.symmetric(horizontal: 4),
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
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                AlertDialog(
                                  title: Text("Seleccione la causa"),
                                  content: ReasonSelector(
                                    demandId: widget.demand.id,
                                    demandsBloc: widget.demandsBloc,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "CANCELAR",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                Expanded(
                  child: OutlineButton(
                      onPressed: () {
                        if (accepted) {
                          widget.demandsBloc
                              .add(StartDemandEvent(widget.demand.id));
                        } else {
                          widget.demandsBloc
                              .add(AcceptDemandEvent(widget.demand.id));
                        }

                        setState(() {
                          loading = true;
                        });
                      },
                      child: loading ?
                      CircularProgressIndicator()   :
                      Text(
                        accepted ? "COMENZAR" : "ACEPTAR",
                        style: TextStyle(color: Colors.green, fontSize: 17),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget startedInboxItem(double width) {
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
                                      "COMENZADA",
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
                                  DateFormat("dd 'de' MMMM 'del' yyyy", "es_ES")
                                      .format(
                                      DateTime.parse(widget.demand.date))
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
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
                                    widget.demand.client.fullname,
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
                    padding: const EdgeInsets.symmetric(horizontal: 4),
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
                              widget.demand.client.phone,
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
                          widget.demand.originAddress.addressText,
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
                          widget.demand.destinationAddress.addressText,
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
                              widget.demand.client.phone,
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
                          widget.demand.destinationAddress.addressText,
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Center(
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  AlertDialog(
                                    title: Text("Seleccione la causa"),
                                    content: ReasonSelector(
                                      demandId: widget.demand.id,
                                      demandsBloc: widget.demandsBloc,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "CANCELAR",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Expanded(
                    child: OutlineButton(
                        onPressed: () {

                        },
                        child: Text(
                          "RECOGER",
                          style: TextStyle(color: Colors.green, fontSize: 17),
                        )),
                  ),
                  Expanded(
                    child: OutlineButton(
                        borderSide: BorderSide(color: Colors.white),
                        onPressed: () {
                          widget.demandsBloc
                              .add(FinishDemandEvent(widget.demand.id));

                          setState(() {
                            loading = true;
                          });
                        },
                        child:loading ?
                        CircularProgressIndicator()   :
                        Text(
                          "FINALIZAR",
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
                                  DateFormat("dd 'de' MMMM 'del' yyyy", "es_ES")
                                      .format(
                                          DateTime.parse(widget.demand.date))
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
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
                                    widget.demand.client.fullname,
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
                    padding: const EdgeInsets.symmetric(horizontal: 4),
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
                                    widget.demand.client.phone,
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
                                widget.demand.originAddress.addressText,
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
                                widget.demand.destinationAddress.addressText,
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
                                    widget.demand.client.phone,
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
                                widget.demand.destinationAddress.addressText,
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
                        onPressed: () {
                          widget.demandsBloc
                              .add(DeclineDemandEvent(widget.demand.id));
                        },
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
}

class ReasonSelector extends StatefulWidget {
  final String demandId;
  final DemandsBloc demandsBloc;

  const ReasonSelector({Key key, this.demandId, this.demandsBloc})
      : super(key: key);

  @override
  _ReasonSelectorState createState() => _ReasonSelectorState();
}

class _ReasonSelectorState extends State<ReasonSelector> {
  String _radioReasonValue = "";
  TextEditingController _reasonCtrl;

  @override
  void initState() {
    _reasonCtrl = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
                value: CancelType.CLIENT_SUSPECT,
                groupValue: _radioReasonValue,
                onChanged: (value) {
                  setState(() {
                    _radioReasonValue = value;
                  });
                }),
            Text("Cliente Sospechoso")
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
                value: CancelType.DANGEROUS_ZONE,
                groupValue: _radioReasonValue,
                onChanged: (value) {
                  setState(() {
                    _radioReasonValue = value;
                  });
                }),
            Text("Zona peligrosa")
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
                value: CancelType.MISSING_CLIENT,
                groupValue: _radioReasonValue,
                onChanged: (value) {
                  setState(() {
                    _radioReasonValue = value;
                  });
                }),
            Text("El cliente no se presentó")
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
                value: CancelType.TECHNICAL_PROBLEMS,
                groupValue: _radioReasonValue,
                onChanged: (value) {
                  setState(() {
                    _radioReasonValue = value;
                  });
                }),
            Text("Problemas técnicos")
          ],
        ),
        Row(
          children: <Widget>[
            Radio(
                value: CancelType.OTHERS,
                groupValue: _radioReasonValue,
                onChanged: (value) {
                  setState(() {
                    _radioReasonValue = value;
                  });
                }),
            Text("Otros")
          ],
        ),
        if (_radioReasonValue == CancelType.OTHERS)
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _reasonCtrl,
                  decoration: InputDecoration(
                      labelText: "Describa la razón",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      hasFloatingPlaceholder: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
              )
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: OutlineButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "No".toUpperCase(),
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
            ),
            Expanded(
              child: OutlineButton(
                onPressed: _radioReasonValue.isNotEmpty
                    ? () {
                        widget.demandsBloc.add(CancelDemandEvent(
                            widget.demandId, _radioReasonValue,
                            reason: _reasonCtrl.text));
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text(
                  "Si, Cancelar".toUpperCase(),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
