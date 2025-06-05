import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  AuthRequest({required this.name, required this.password});
  final String name;
  final String password;
  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
