import 'package:flutter/material.dart';

import 'index.dart';

class SDemandPage extends StatelessWidget {
  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    var _sDemandBloc = new SDemandBloc();
    return new Scaffold(      
      body: new SDemandScreen(sDemandBloc: _sDemandBloc),
    );
  }
}
