import 'package:dtaxi_driver/src/bloc/authentication/authentication_model.dart';
import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'demands_model.g.dart';

class DemandsResponse extends ResponseModel<Demand> {
  List<Demand> results;

  DemandsResponse({this.results});

  DemandsResponse.fromJson(Map<String, dynamic> json) {
    results = new List<Demand>();
    if (json['demandsByStatesV2'] != null &&
        (json['demandsByStatesV2'] as List).isNotEmpty) {
      var list = json['demandsByStatesV2'] as List;
      list.forEach((d) => results.add(Demand.fromJson(d)));
    } else
      results = [];
  }
}

@JsonSerializable()
class Demand {
  final String id;
  final String date;
  final DemandAddress originAddress;
  final DemandAddress destination;
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
      this.destination,
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
  Map<String, dynamic> toJson() => _$DemandToJson(this);
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
  static const SENDED = "SENDED";
  static const ACCEPTED = "ACCEPTED";
  static const ASSIGNED = "ASSIGNED";
  static const IN_COURSE = "IN_COURSE";
  static const CANCELED = "CANCELED";
}
