// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demands_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Demand _$DemandFromJson(Map<String, dynamic> json) {
  return Demand(
    json['id'] as String,
    json['date'] as String,
    json['originAddress'] == null
        ? null
        : DemandAddress.fromJson(json['originAddress'] as Map<String, dynamic>),
    json['destination'] == null
        ? null
        : DemandAddress.fromJson(json['destination'] as Map<String, dynamic>),
    json['client'] == null
        ? null
        : Client.fromJson(json['client'] as Map<String, dynamic>),
    json['lostFound'] as Map<String, dynamic>,
    json['state'] as String,
    json['annotation'] as String,
    json['driverAnnotation'] as String,
    (json['price'] as num)?.toDouble(),
    json['driver'] == null
        ? null
        : Driver.fromJson(json['driver'] as Map<String, dynamic>),
    json['callCenterId'] as String,
    json['alarmTimeBefore'] as int,
    json['canceledType'] as String,
  );
}

Map<String, dynamic> _$DemandToJson(Demand instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'originAddress': instance.originAddress,
      'destination': instance.destination,
      'client': instance.client,
      'lostFound': instance.lostFound,
      'state': instance.state,
      'annotation': instance.annotation,
      'driverAnnotation': instance.driverAnnotation,
      'price': instance.price,
      'driver': instance.driver,
      'callCenterId': instance.callCenterId,
      'alarmTimeBefore': instance.alarmTimeBefore,
      'canceledType': instance.canceledType,
    };

DemandAddress _$DemandAddressFromJson(Map<String, dynamic> json) {
  return DemandAddress(
    json['addressText'] as String,
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DemandAddressToJson(DemandAddress instance) =>
    <String, dynamic>{
      'addressText': instance.addressText,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Client _$ClientFromJson(Map<String, dynamic> json) {
  return Client(
    json['id'] as String,
    json['fullname'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'phone': instance.phone,
    };
