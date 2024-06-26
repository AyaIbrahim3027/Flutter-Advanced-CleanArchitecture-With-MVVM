import 'package:advanced_flutter/data/network/error_handler.dart';

import '../response/responses.dart';

const CACHE_HOME_KEY = 'CACHE_HOME_KEY';
const CACHE_HOME_INTERVAL = 60*1000; // 1 minute cache in millisecond
const CACHE_STORE_DETAILS_KEY = 'CACHE_STORE_DETAILS_KEY';
const CACHE_STORE_DETAILS_INTERVAL = 60*1000;


abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
  Future<StoreDetailsResponse> getStoreDetails();
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse storeDetailsResponse);
}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return response from cache
      return cachedItem.data;
    } else {
      // return an error that cache isn't there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null &&
        cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);
  }

}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{
  bool isValid(int expirationTimeInMillisecond){

    int currentTimeInMillisecond = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillisecond - cacheTime <= expirationTimeInMillisecond;
    return isValid;
  }
}
