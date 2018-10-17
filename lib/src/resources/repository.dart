import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[newsDbProvider, newsApiProvider];
  List<Cache> caches = <Cache>[newsDbProvider];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    for (Source source in sources) item ??= await source.fetchItem(id);
    for (Cache cache in caches) cache.addItem(item);
    return item;
  }

  clearCache() async{
    for(Cache cache in caches){
      await cache.clear();
    }
  }

}

abstract class Source {
  Future<List<int>> fetchTopIds();

  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> clear();
  Future<int> addItem(ItemModel item);
}
