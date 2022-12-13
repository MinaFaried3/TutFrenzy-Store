import 'package:frenzy_store/data/response/responses.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'image')
  final String? image;

  ServiceResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
}

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'image')
  final String? image;

  BannerResponse(this.id, this.link, this.title, this.image);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}

@JsonSerializable()
class StoreResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'image')
  final String? image;

  StoreResponse(this.id, this.title, this.image);

  Map<String, dynamic> toJson() => _$StoreResponseToJson(this);

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreResponseFromJson(json);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  final List<ServiceResponse>? services;
  @JsonKey(name: 'banners')
  final List<BannerResponse>? banners;
  @JsonKey(name: 'stores')
  final List<StoreResponse>? stores;

  HomeDataResponse(this.services, this.banners, this.stores);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  final HomeDataResponse? data;

  HomeResponse(this.data);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}
