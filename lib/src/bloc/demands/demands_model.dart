import 'package:dtaxi_driver/src/bloc/authentication/authentication_model.dart';
import 'package:dtaxi_driver/src/bloc/utils/db/dbhelper.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

part 'demands_model.g.dart';

class DemandsResponse extends ResponseModel<Demand> {
  List<Demand> results;

  DemandsResponse({this.results});

  DemandsResponse.fromJson(Map<String, dynamic> json, String key) {
    results = new List<Demand>();
    if (json[key] != null &&
        json[key] is List &&
        (json[key] as List).isNotEmpty) {
      var list = json[key] as List;
      list.forEach((d) => results.add(Demand.fromJson(d)));
    } else if (json[key] != null &&
        json[key] is Map &&
        (json[key] as Map).isNotEmpty) {
      results.add(Demand.fromJson(json[key]));
    } else
      results = [];
  }
}

@JsonSerializable(nullable: true)
class Demand {
  final String id;
  final String date;
  final DemandAddress originAddress;
  final DemandAddress destinationAddress;
  final Client client;
  final Map lostFound;
  final String state;
  final String annotation;
  final String driverAnnotation;
  final double price;
  final Driver driver;
  final String callCenterId;
  final int alarmTimeBefore;
  final String canceledType;

  Demand(
      this.id,
      this.date,
      this.originAddress,
      this.destinationAddress,
      this.client,
      this.lostFound,
      this.state,
      this.annotation,
      this.driverAnnotation,
      this.price,
      this.driver,
      this.callCenterId,
      this.alarmTimeBefore,
      this.canceledType);

  factory Demand.fromJson(Map<String, dynamic> json) => _$DemandFromJson(json);

  static Map<String, String> getFieldsForDB() {
    return {
      "id": DBType.PRIMARY_KEY,
      "date": DBType.TEXT,
      "originAddress": DBType.TEXT,
      "originLatitude": DBType.DOUBLE,
      "originLongitude": DBType.DOUBLE,
      "destinationAddress": DBType.TEXT,
      "destinationLattitude": DBType.DOUBLE,
      "destinationLongitude": DBType.DOUBLE,
      "clientId": DBType.TEXT,
      "clientName": DBType.TEXT,
      "clientPhone": DBType.TEXT,
      "state": DBType.TEXT,
      "annotation": DBType.TEXT,
      "driverAnnotation": DBType.TEXT,
      "price": DBType.DOUBLE,
      "driverId": DBType.TEXT,
      "driverName": DBType.TEXT,
      "driverUserId": DBType.TEXT,
      "callCenterId": DBType.TEXT,
      "alarmTimeBefore": DBType.INTEGER,
      "canceledType": DBType.TEXT,
    };
  }

  Demand.fromDBJson(Map json)
      : id = json['id'],
        date = json['date'],
        originAddress = DemandAddress(json['originAddress'],
            json['originLatitude'], json['originLongitude']),
        destinationAddress = DemandAddress(json['destinationAddress'],
            json['destinationLattitude'], json['destinationLongitude']),
        client =
            Client(json['clientId'], json['clientName'], json['clientPhone']),
        state = json['state'],
        lostFound = <String, dynamic>{},
        annotation = json['annotation'],
        driverAnnotation = json['driverAnnotation'],
        price = json['price'],
        driver =
            Driver(json['driverId'], json['driverName'], json['driverUserId']),
        callCenterId = json['callCenterId'],
        alarmTimeBefore = json['alarmTimeBefore'],
        canceledType = json['canceledType'];

  Map<String, dynamic> toDBJson() => <String, dynamic>{
        "id": id,
        "date": date,
        "originAddress": originAddress.addressText,
        "originLatitude": originAddress.latitude,
        "originLongitude": originAddress.longitude,
        "destinationAddress": destinationAddress.addressText,
        "destinationLattitude": destinationAddress.latitude,
        "destinationLongitude": destinationAddress.longitude,
        "clientId": client.id,
        "clientName": client.fullname,
        "clientPhone": client.phone,
        "state": state,
        "annotation": annotation,
        "driverAnnotation": driverAnnotation,
        "price": price,
        "driverId": driver.id,
        "driverName": driver.name,
        "driverUserId": driver.userId,
        "callCenterId": callCenterId,
        "alarmTimeBefore": alarmTimeBefore,
        "canceledType": canceledType,
      };

  Map<String, dynamic> toJson() => _$DemandToJson(this);

  String getState() {
    switch (state) {
      case DemandType.PENDING:
        return "PENDIENTE";
        break;
      case DemandType.ASSIGNED:
        return "ASIGNADA";
        break;
      case DemandType.ACCEPTED:
        return "ACEPTADA";
        break;
      case DemandType.SENT:
        return "NUEVO";
        break;
      case DemandType.CANCELED:
        return "CANCELADA";
        break;
      case DemandType.IN_COURSE:
        return "EN CURSO";
        break;
      default:
        return "ESTADO DESCONOCIDO";
        break;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is Demand &&
        this.id == other.id &&
        this.date == other.date &&
        this.originAddress == other.originAddress &&
        this.destinationAddress == other.destinationAddress &&
        this.client == other.client &&
        this.lostFound == other.lostFound &&
        this.state == other.state &&
        this.annotation == other.annotation &&
        this.driverAnnotation == other.driverAnnotation &&
        this.price == other.price &&
        this.driver == other.driver &&
        this.callCenterId == other.callCenterId &&
        this.alarmTimeBefore == other.alarmTimeBefore &&
        this.canceledType == other.canceledType;
  }

  @override
  int get hashCode {
    return hashObjects([
      this.id,
      this.date,
      this.originAddress,
      this.destinationAddress,
      this.client,
      this.lostFound,
      this.state,
      this.annotation,
      this.driverAnnotation,
      this.price,
      this.driver,
      this.callCenterId,
      this.alarmTimeBefore,
      this.canceledType,
    ].where((s) => s != null));
  }
}

@JsonSerializable()
class DemandAddress {
  final String addressText;
  final double latitude;
  final double longitude;

  DemandAddress(this.addressText, this.latitude, this.longitude);

  factory DemandAddress.fromJson(Map<String, dynamic> json) =>
      _$DemandAddressFromJson(json);

  Map<String, dynamic> toJson() => _$DemandAddressToJson(this);
}

@JsonSerializable()
class Client {
  final String id;
  final String fullname;
  final String phone;

  Client(this.id, this.fullname, this.phone);

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

class DemandType {
  static const PENDING = "PENDING";
  static const SENT = "SENT";
  static const ACCEPTED = "ACCEPTED";
  static const ASSIGNED = "ASSIGNED";
  static const IN_COURSE = "IN_COURSE";
  static const CANCELED = "CANCELED";
}

class CancelType {
  static const CLIENT_SUSPECT = "CLIENT_SUSPECT";
  static const DANGEROUS_ZONE = "DANGEROUS_ZONE";
  static const MISSING_CLIENT = "MISSING_CLIENT";
  static const TECHNICAL_PROBLEMS = "TECHNICAL_PROBLEMS";
  static const OTHERS = "OTHERS";
}
