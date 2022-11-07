import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class BaseResponse extends Equatable {
  @JsonKey(name: "status")
  final int? status;
  @JsonKey(name: "message")
  final String? message;

  const BaseResponse(this.status, this.message);
  @override
  List<Object?> get props => [status, message];
}

@JsonSerializable()
class CustomerResponse extends Equatable {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "numOfNotification")
  final int? notificationNumber;

  const CustomerResponse(this.id, this.name, this.notificationNumber);

  //from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  //to json
  Map<String, dynamic> toJSon() => _$CustomerResponseToJson(this);

  @override
  List<Object?> get props => [id, name, notificationNumber];
}

@JsonSerializable()
class ContactsResponse extends Equatable {
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "link")
  final String? link;

  const ContactsResponse(this.phone, this.email, this.link);

  //from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  //to json
  Map<String, dynamic> toJSon() => _$ContactsResponseToJson(this);

  @override
  List<Object?> get props => [phone, email, link];
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  final CustomerResponse? customer;
  @JsonKey(name: "contacts")
  final ContactsResponse? contacts;

  const AuthenticationResponse(
      this.customer, this.contacts, super.status, super.message);

  //from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  //to json
  Map<String, dynamic> toJSon() => _$AuthenticationResponseToJson(this);

  @override
  List<Object?> get props => [customer, contacts];
}
