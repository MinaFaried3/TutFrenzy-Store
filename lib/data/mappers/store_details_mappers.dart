import 'package:frenzy_store/app/constants.dart';
import 'package:frenzy_store/app/extension.dart';
import 'package:frenzy_store/data/response/store_details_response.dart';
import 'package:frenzy_store/domain/models/store_details_model.dart';

extension StoreDetailsMappers on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      id: this?.id.orZero() ?? Constants.zero,
      title: this?.title.orEmpty() ?? Constants.empty,
      image: this?.image.orEmpty() ?? Constants.empty,
      details: this?.details.orEmpty() ?? Constants.empty,
      services: this?.services.orEmpty() ?? Constants.empty,
      about: this?.about.orEmpty() ?? Constants.empty,
    );
  }
}
