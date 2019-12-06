import 'package:dtaxi_driver/src/ui/inbox.dart';
import 'package:dtaxi_driver/src/ui/inbox_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

class SDemandScreen extends StatefulWidget {
  const SDemandScreen({
    Key key,
    @required SDemandBloc sDemandBloc,
  })  : _sDemandBloc = sDemandBloc,
        super(key: key);

  final SDemandBloc _sDemandBloc;

  @override
  SDemandScreenState createState() {
    return new SDemandScreenState(_sDemandBloc);
  }
}

class SDemandScreenState extends State<SDemandScreen> {
  final SDemandBloc _sDemandBloc;

  SDemandScreenState(this._sDemandBloc);

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  void initState() {
    _sDemandBloc.dispatch(LoadSDemandEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: BlocBuilder<SDemandBloc, SDemandState>(
        bloc: widget._sDemandBloc,
        builder: (
          BuildContext context,
          SDemandState currentState,
        ) {
          if (currentState is UnSDemandState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (currentState is ErrorSDemandState) {
            print("ErrorSDemandUi");
            return loading();
          } else if (currentState is InPenddingDemandState) {
            return Inbox(
              acceptedItems: currentState.accepted,
              inboxItems: currentState.pending,
              sDemandBloc: widget._sDemandBloc,

            );
          } else
            return Container();
        },
      ),
    );
  }

  Widget loading() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue.shade400,
        child: Center(
          child: CircularProgressIndicator(backgroundColor: Colors.white),
        ));
  }
}
