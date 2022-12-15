import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/app/extension.dart';
import 'package:frenzy_store/data/response/home_response.dart';
import 'package:frenzy_store/domain/models/home_model.dart' as home;
import 'package:frenzy_store/domain/models/home_model.dart';

extension Service on ServiceResponse? {
  home.Service toDomain() => home.Service(
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
        services: (this?.services?.map((service) => service.toDomain()) ??
                const Iterable.empty())
            .cast<home.Service>()
            .toList(),
        banners: (this?.banners?.map((banner) => banner.toDomain()) ??
                const Iterable.empty())
            .cast<Banner>()
            .toList(),
        stores: (this?.stores?.map((store) => store.toDomain()) ??
                const Iterable.empty())
            .cast<Store>()
            .toList(),
      );
}

extension HomeMapper on HomeResponse? {
  Home toDomain() => Home(data: this?.data.toDomain());
}
