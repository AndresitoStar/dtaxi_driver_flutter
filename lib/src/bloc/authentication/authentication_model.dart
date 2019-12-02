import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_model.g.dart';

class AuthenticationResponse extends ResponseModel<AuthenticationModel> {
  List<AuthenticationModel> results;

  AuthenticationResponse({this.results});

  AuthenticationResponse.fromJson(Map<String, dynamic> json, String key) {
    if (json[key] != null) {
      results = [AuthenticationModel.fromJson(json[key])];
    } else
      results = [];
  }
}

@JsonSerializable()
class AuthenticationModel extends Equatable {
  final String token;
  final String fullname;
  final Map role;

  AuthenticationModel(this.token, this.fullname, this.role);

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);
}

@JsonSerializable()
class Driver {
  final String id;
  final String name;
  final String userId;

  Driver(this.id, this.name, this.userId);

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
