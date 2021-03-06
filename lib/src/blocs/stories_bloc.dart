import 'dart:async';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  Function(int) get fetchItem => _itemsFetcher.add;

  StoriesBloc() {
    _itemsFetcher.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.add(ids);
  }

  clearCache(){
    return _repository.clearCache();
  }

  _itemsTransformer() =>
      ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
          (Map<int, Future<ItemModel>> cache, int id, int index) {
//            print(index);
        cache[id] = _repository.fetchItem(id);
        return cache;
      }, <int, Future<ItemModel>>{});

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
