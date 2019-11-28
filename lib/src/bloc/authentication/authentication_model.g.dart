// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationModel _$AuthenticationModelFromJson(Map<String, dynamic> json) {
  return AuthenticationModel(
    json['token'] as String,
    json['fullname'] as String,
  );
}

Map<String, dynamic> _$AuthenticationModelToJson(
        AuthenticationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'fullname': instance.fullname,
    };
