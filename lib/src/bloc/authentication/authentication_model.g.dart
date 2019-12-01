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
  );
}

Map<String, dynamic> _$AuthenticationModelToJson(
        AuthenticationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'fullname': instance.fullname,
      'role': instance.role,
    };

Driver _$DriverFromJson(Map<String, dynamic> json) {
  return Driver(
    json['id'] as String,
    json['name'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
    };
