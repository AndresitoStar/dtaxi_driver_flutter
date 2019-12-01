import 'package:dtaxi_driver/src/bloc/utils/response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_model.g.dart';

class AuthenticationResponse extends ResponseModel<AuthenticationModel> {
  List<AuthenticationModel> results;

  AuthenticationResponse({this.results});

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    if (json['login'] != null) {
      results = [AuthenticationModel.fromJson(json['login'])];
    } else
      results = [];
  }

  Map<String, dynamic> toJson(bool createCard) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
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
