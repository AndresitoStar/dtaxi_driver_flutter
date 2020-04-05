import 'package:dtaxi_driver/src/bloc/localization/localization_bloc.dart';
import 'package:dtaxi_driver/src/common/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_page.dart';
import 'bloc/demands/demands_model.dart';
import 'bloc/utils/db/dbInitHelper.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DBInitHelper helper = DBInitHelper(dbTablesName: [
      'demand',
    ], tablesField: [
      Demand.getFieldsForDB()]);
    helper.initDb();

    /*PermissionHandler().requestPermissions([
      PermissionGroup.location,
      PermissionGroup.storage,
    ]);*/

    return MaterialApp(
      title: 'Dtaxi Driver',
      theme: dtaxiThemeData,
      //home: Homepage(title: 'Flutter Demo Home Page', tab: HomepageTab.INBOX),
      home: BlocProvider<LocalizationBloc>(
          create: (BuildContext context) => LocalizationBloc(),
          child: AuthenticationPage()),
    );
  }
}
