import 'dart:async';

//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

abstract class ILocationService {
  void startLocationService();
  void getLocationUpdates(Function(Position) callback);
  void stopLocationService();
  Future<Position> getCurrentLocation();
}

/*
class LocationService extends iLocationService {
  Location _location = new Location();
  StreamController<LocationData> stream;

  static final LocationService _localizationServiceSingleton =
  new LocationService._internal();

  factory LocationService() {
    return _localizationServiceSingleton;
  }

  LocationService._internal();

  @override
  void getLocationUpdates(Function(LocationData) callback) {
    if (stream == null) {
      startLocationService();
    }

    stream.stream.listen((data) {
      Function.apply(callback, [data]);
    });
  }


  Future<LocationData> getCurrentLocation(){
    return _location.getLocation();
  }

  @override
  void startLocationService() {
    _location.changeSettings(accuracy: LocationAccuracy.NAVIGATION);

    stream = new StreamController<LocationData>();
    _location.onLocationChanged().listen((locationData){
      if(locationData != null){
        if(!stream.isClosed)
          stream.add(locationData);
      }
    });
  }

  @override
  void stopLocationService() {
    _location.onLocationChanged().drain();
    stream.close();
  }

}*/


class LocationService extends ILocationService{
  Geolocator geolocator = new Geolocator();
  StreamSubscription<Position> subscription;
  Stream<Position> stream;

  static final LocationService _localizationServiceSingleton =
  new LocationService._internal();

  factory LocationService() {
    return _localizationServiceSingleton;
  }

  LocationService._internal();


  @override
  void getLocationUpdates(Function(Position) callback) {
    if (stream == null) {
      startLocationService();
    }

    subscription = stream.listen((data) {
      Function.apply(callback, [data]);
    });
  }

  @override
  void startLocationService() {
    LocationOptions options = LocationOptions(accuracy: LocationAccuracy.high, /*distanceFilter: 25,*/ timeInterval: 5000);
    stream = geolocator.getPositionStream(options, GeolocationPermission.locationAlways);
  }

  @override
  void stopLocationService() {
    subscription.cancel();
  }

  @override
  Future<Position> getCurrentLocation() {
    return geolocator.getCurrentPosition();
  }

}