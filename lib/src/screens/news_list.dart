import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/src/blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Text('${snapshot.data[index]}');
//            return FutureBuilder(
//            );
          },
        );
      },
    );
  }

//  Widget buildList() {
////    Text('Show some news here!');
//    return ListView.builder(
//      itemCount: 1000,
//      itemBuilder: (BuildContext context, int index) {
//        return FutureBuilder(
//          future: getFuture(),
//          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//            debugPrint(index.toString());
//            return snapshot.hasData
//                ? Text(snapshot.data)
//                : Text('Not yet data');
//          },
//        );
//      },
//    );
//  }
//
//  Future<String> getFuture() {
//    return Future.delayed(
//      Duration(seconds: 2),
//      () => 'hi',
//    );
//  }
}
