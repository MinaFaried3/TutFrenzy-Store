import 'package:frenzy_store/data/response/responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  final String? supportMessage;

  ForgotPasswordResponse(this.supportMessage);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}
