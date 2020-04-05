import 'dart:async';

import 'package:dtaxi_driver/src/bloc/authentication/authentication_repository.dart';
import 'package:dtaxi_driver/src/bloc/localization/localization_service.dart';
import 'package:dtaxi_driver/src/bloc/utils/secure_storage.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';

import 'localization_bloc.dart';

abstract class LocalizationEvent {
  Future<LocalizationState> applyAsync(
      {LocalizationState currentState, LocalizationBloc bloc});

  final AuthenticationRepository _authenticationRepository =
      new AuthenticationRepository();

  final LocationService _locationService = new LocationService();
}

class StartLocationBroadcastEvent extends LocalizationEvent {
  @override
  Future<LocalizationState> applyAsync(
      {LocalizationState currentState, LocalizationBloc bloc}) async {
    _locationService.startLocationService();
    _locationService.getLocationUpdates((Position location){
        bloc.add(SendLocationEvent(location));
    });
    return LocalizationState.INIT;
  }
}

class SendLocationEvent extends LocalizationEvent {
  final Position currLocation;


  SendLocationEvent(this.currLocation);

  @override
  Future<LocalizationState> applyAsync(
      {LocalizationState currentState, LocalizationBloc bloc}) async {
    SecureStorage.getUserData().then((user){
      if(user != null && user.driver != null && user.driver.id != null) {
        print("☺☺☺ [${currLocation.timestamp}] SENDED LOCATION: [${currLocation.latitude}|${currLocation.longitude}] ☺☺☺");
        _authenticationRepository.updateDriverState(
            user.driver.id, user.driver.state, location: currLocation);
      } else
        print("☻☻☻ Location not sended becouse USER is NULL");
    });
    return LocalizationState.BROADCASTING;
  }
}

class StopLocationBroadcastEvent extends LocalizationEvent {
  @override
  Future<LocalizationState> applyAsync(
      {LocalizationState currentState, LocalizationBloc bloc}) async {
    _locationService.stopLocationService();
    return LocalizationState.STOPPED;
  }
}
