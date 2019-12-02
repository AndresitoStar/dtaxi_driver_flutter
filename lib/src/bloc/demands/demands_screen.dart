import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/ui/inbox_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsScreen extends StatefulWidget {
  const DemandsScreen(
      {Key key,
      @required DemandsBloc demandsBloc,
      this.demandsByDriver = false})
      : _demandsBloc = demandsBloc,
        super(key: key);

  final DemandsBloc _demandsBloc;
  final bool demandsByDriver;

  @override
  DemandsScreenState createState() {
    return new DemandsScreenState(_demandsBloc);
  }
}

class DemandsScreenState extends State<DemandsScreen> {
  final DemandsBloc _demandsBloc;

  DemandsScreenState(this._demandsBloc);

  @override
  void initState() {
    _demandsBloc
        .dispatch(LoadDemandsEvent(demandsByDriver: widget.demandsByDriver));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: BlocBuilder<DemandsBloc, DemandsState>(
          bloc: widget._demandsBloc,
          builder: (
            BuildContext context,
            DemandsState currentState,
          ) {
            if (currentState is UnDemandsState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is ErrorDemandsState) {
              return Container(
                  child: Center(
                child: Text(currentState.errorMessage ?? 'Error'),
              ));
            }
            if (currentState is InDemandsState) {
              if (currentState.error != null)
                Future.microtask(() => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(currentState.error),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                _demandsBloc.dispatch(LoadDemandsEvent(
                                    demandsByDriver: widget.demandsByDriver));
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )));
              return ListView.builder(
                itemCount: currentState.demands.length,
                itemBuilder: (context, index) {
                  return InboxItem(
                    demand: currentState.demands[index],
                    demandsBloc: widget._demandsBloc,
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}
