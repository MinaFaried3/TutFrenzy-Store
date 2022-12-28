import 'package:equatable/equatable.dart';
import 'package:frenzy_store/data/response/home_response.dart';

import '../network/error_handler.dart';

const String cacheHomeKey = "CACHE_HOME_KEY";
const int cacheHomeInterval = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeDataToCache(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl extends LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

    if (cachedItem == null || cachedItem.isValid(cacheHomeInterval)) {
      throw ErrorHandler.handle(DataSource.cacheError);
    }

    return cachedItem.data;
  }

  @override
  Future<void> saveHomeDataToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem<HomeResponse>(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem<T> extends Equatable {
  final T data;

  final int cacheTime = DateTime.now().microsecondsSinceEpoch;

  CachedItem(this.data);

  @override
  List<dynamic> get props => [data, cacheTime];
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    bool valid = currentTime - cacheTime <= expirationTimeInMillis;

    return valid;
  }
}
