import 'package:bloc/bloc.dart';
import 'package:dtaxi_driver/src/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition.toString());
    super.onTransition(bloc, transition);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  initializeDateFormatting("es_ES", null).then((_) => runApp(App()));
}
