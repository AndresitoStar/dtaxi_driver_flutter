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

class DriverResponse extends ResponseModel<Driver>{
  List<Driver> results;

  DriverResponse({this.results});

  DriverResponse.fromJson(Map<String, dynamic> json, String key) {
    if (json[key] != null) {
      results = [Driver.fromJson(json[key])];
    } else
      results = [];
  }
}

@JsonSerializable()
class AuthenticationModel extends Equatable {
  final String token;
  final String fullname;
  final Map role;
  final String profileImageId;
  final Driver driver;

  AuthenticationModel(this.token, this.fullname, this.role, this.profileImageId, this.driver);

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationModelToJson(this);
}

@JsonSerializable()
class Driver {
  final String id;
  final String name;
  final num score;
  final String userId;
  final String phone;
  final String state;

  Driver(this.id, this.name, this.userId, {this.score, this.phone, this.state});

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
