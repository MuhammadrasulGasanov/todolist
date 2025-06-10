import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.g.dart';
part 'auth_request.freezed.dart';

@freezed
sealed class AuthRequest with _$AuthRequest {
  factory AuthRequest({required String username, required String password}) =
      _AuthRequest;
  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
}
