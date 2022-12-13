import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/app/extension.dart';
import 'package:frenzy_store/data/response/home_response.dart';
import 'package:frenzy_store/domain/models/home_model.dart';

extension ServiceMapper on ServiceResponse? {
  ServiceModel toDomain() => ServiceModel(
        id: this?.id?.orZero() ?? Constants.zero,
        title: this?.title?.orEmpty() ?? Constants.empty,
        image: this?.image?.orEmpty() ?? Constants.empty,
      );
}

extension BannerMapper on BannerResponse? {
  Banner toDomain() => Banner(
        id: this?.id?.orZero() ?? Constants.zero,
        link: this?.link?.orEmpty() ?? Constants.empty,
        title: this?.title?.orEmpty() ?? Constants.empty,
        image: this?.image?.orEmpty() ?? Constants.empty,
      );
}

extension StoreMapper on StoreResponse? {
  Store toDomain() => Store(
        id: this?.id?.orZero() ?? Constants.zero,
        title: this?.title?.orEmpty() ?? Constants.empty,
        image: this?.image?.orEmpty() ?? Constants.empty,
      );
}

extension HomeDataMapper on HomeDataResponse? {
  HomeData toDomain() => HomeData(
        services: this?.services?.map((service) => service.toDomain()).toList(),
        banners: this?.banners?.map((banner) => banner.toDomain()).toList(),
        stores: this?.stores?.map((store) => store.toDomain()).toList(),
      );
}
