import 'package:frenzy_store/data/response/responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'image')
  final String? image;

  ServicesResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);

  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);
}

@JsonSerializable()
class BannersResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'image')
  final String? image;

  BannersResponse(this.id, this.link, this.title, this.image);

  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);

  factory BannersResponse.fromJson(Map<String, dynamic> json) =>
      _$BannersResponseFromJson(json);
}

@JsonSerializable()
class StoresResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'image')
  final String? image;

  StoresResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$StoresResponseToJson(this);

  factory StoresResponse.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse extends BaseResponse {
  @JsonKey(name: 'services')
  final List<ServicesResponse>? services;
  @JsonKey(name: 'banners')
  final List<BannersResponse>? banners;
  @JsonKey(name: 'stores')
  final List<StoresResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}
