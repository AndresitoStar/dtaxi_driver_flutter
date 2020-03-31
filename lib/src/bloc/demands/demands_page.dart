import 'package:dtaxi_driver/src/bloc/demands/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemandsPage extends StatelessWidget {
  static const String routeName = "/demands";

  @override
  Widget build(BuildContext context) {
    var _demandsBloc = DemandsBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text("Demands"),
      ),
      body: DemandsScreen(demandsBloc: _demandsBloc, state: DemandScreenState.PENDING,),
    );
  }
}
