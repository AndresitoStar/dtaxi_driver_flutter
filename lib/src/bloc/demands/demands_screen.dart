import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemandsScreen extends StatefulWidget {
  const DemandsScreen(
      {Key key, @required DemandsBloc demandsBloc, this.demandTypes})
      : _demandsBloc = demandsBloc,
        super(key: key);

  final DemandsBloc _demandsBloc;
  final List<String> demandTypes;

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
    super.initState();
    this._demandsBloc.dispatch(LoadDemandsEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DemandsBloc, DemandsState>(
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
            return Container();
          }
          return Container();
        });
  }
}
