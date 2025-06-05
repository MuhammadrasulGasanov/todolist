import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  AuthResponse({this.token, required this.userID, required this.userName});
  final String? token;
  final int userID;
  final String userName;
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
