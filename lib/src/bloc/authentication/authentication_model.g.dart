// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationModel _$AuthenticationModelFromJson(Map<String, dynamic> json) {
  return AuthenticationModel(
    json['token'] as String,
    json['fullname'] as String,
    json['role'] as Map<String, dynamic>,
    json['profileImageId'] as String,
    json['driver'] == null
        ? null
        : Driver.fromJson(json['driver'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AuthenticationModelToJson(
        AuthenticationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'fullname': instance.fullname,
      'role': instance.role,
      'profileImageId': instance.profileImageId,
      'driver': instance.driver,
    };

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return Driver(
    json['id'] as String,
    json['name'] as String,
    json['userId'] as String,
    score: json['score'] as num,
    phone: json['phone'] as String,
    state: json['state'] as String,
  );
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'score': instance.score,
      'userId': instance.userId,
      'phone': instance.phone,
      'state': instance.state,
    };
