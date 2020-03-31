import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:dtaxi_driver/src/ui/inbox_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DemandScreenState {
  static const int PENDING = 1;
  static const int ACCEPTED = 2;
}

class DemandsScreen extends StatefulWidget {
  const DemandsScreen({
    Key key,
    @required DemandsBloc demandsBloc,
    @required int state
  })  : _demandsBloc = demandsBloc,
        _state = state,
        super(key: key);

  final DemandsBloc _demandsBloc;
  final int _state;

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
    _demandsBloc.add(LoadDemandsEvent());
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
              if (currentState.error != null) {
                Future.microtask(() => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(currentState.error),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                _demandsBloc.add(LoadDemandsEvent());
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )));
              }

              if(this.widget._state == DemandScreenState.PENDING){
                return new RefreshIndicator(
                  onRefresh: refreshList,
                  child: ListView.builder(
                    itemCount: currentState.pendingDemands.length,
                    itemBuilder: (context, index) {
                      return InboxItem(
                        demand: currentState.pendingDemands[index],
                        demandsBloc: this._demandsBloc,
                      );
                    },
                  ),
                );
              } else {
                return new RefreshIndicator(
                  onRefresh: refreshList,
                  child: ListView.builder(
                    itemCount: currentState.acceptedDemands.length,
                    itemBuilder: (context, index) {
                      return InboxItem(
                        demand: currentState.acceptedDemands[index],
                        demandsBloc: this._demandsBloc,
                      );
                    },
                  ),
                );
              }

            }
            return Container();
          }),
    );
  }

  Future<void> refreshList() {
    _demandsBloc.add(LoadDemandsEvent());
  }
}
